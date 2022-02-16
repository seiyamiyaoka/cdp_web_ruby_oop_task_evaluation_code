require "spec_helper"

RSpec.describe Cart do
  let(:customer) { build(:customer) }
  let(:cart) { build(:cart, owner: customer) }
  let(:seller) { build(:seller) }
  let(:item) { build(:item, owner: seller) }

  it "Must include ItemManager" do
    expect(Cart.included_modules.include?(ItemManager)).to eq true
  end
  it "Must include Ownable" do
    expect(Cart.included_modules.include?(Ownable)).to eq true
  end

  describe "#initialize" do
    it "Must have an @owner" do
      expect(cart.instance_variable_get(:@owner)).to be_truthy
    end
    it "To have @items" do
      expect(cart.instance_variable_get(:@items)).to be_truthy
    end
  end

  describe "#items" do
    it "To return @items (overriding ItemManager#items)" do
      expect(cart.items).to eq cart.instance_variable_get(:@items)
    end
  end

  describe "#add(item)" do
    it "to be stored in @items" do
      cart.add(item)
      expect(cart.instance_variable_get(:@items).include?(item)).to eq true
    end
  end

  describe "#total_amount" do
    it "To return the sum of the prices of the Item objects stored in @items" do
      cart.add(item)
      expect(cart.total_amount).to eq item.price
    end
  end

  describe "#check_out" do
    let(:balance) { 99999999999 }
    before do
      customer.wallet.deposit(balance)
      # before check_out
      expect(customer.wallet.balance == balance).to eq true
      expect(item.owner == seller).to eq true
      expect(seller.wallet.balance == 0).to eq true

      cart.add(item)
    end
    it "The purchase amount of all items in the cart (Cart#items) should be transferred from the wallet of the cart owner to the wallet of the item owner." do
      total_amount = cart.total_amount
      cart.check_out
      expect(customer.wallet.balance == (balance - total_amount)).to eq true
      expect(seller.wallet.balance == total_amount).to eq true
    end
    it "The owner rights of all items in the cart (Cart#items) should be transferred to the owner of the cart." do
      items = cart.items
      cart.check_out
      expect(items.all?{|item| item.owner == customer }).to eq true
    end
    it "The contents of the cart (Cart#items) must be empty" do
      expect(cart.items != []).to eq true
      cart.check_out
      expect(cart.items == []).to eq true
    end
  end
end

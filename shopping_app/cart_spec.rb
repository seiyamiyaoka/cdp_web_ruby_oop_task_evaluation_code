require "spec_helper"

RSpec.describe Cart do
  let(:customer) { build(:customer) }
  let(:cart) { build(:cart, owner: customer) }
  let(:seller) { build(:seller) }
  let(:item) { build(:item, owner: seller) }

  it "ItemManagerをincludeしていること" do
    expect(Cart.included_modules.include?(ItemManager)).to eq true
  end
  it "Ownableをincludeしていること" do
    expect(Cart.included_modules.include?(Ownable)).to eq true
  end

  describe "#initialize" do
    it "@ownerを持つこと" do
      expect(cart.instance_variable_get(:@owner)).to be_truthy
    end
    it "@itemsを持つこと" do
      expect(cart.instance_variable_get(:@items)).to be_truthy
    end
  end

  describe "#items" do
    it "@itemsを返すこと（ItemManager#itemsをオーバーライドしている）" do
      expect(cart.items).to eq cart.instance_variable_get(:@items)
    end
  end

  describe "#add(item)" do
    it "@itemsに格納されること" do
      cart.add(item)
      expect(cart.instance_variable_get(:@items).include?(item)).to eq true
    end
  end

  describe "#total_amount" do
    it "@itemsに格納されているItemオブジェクトの値段の合計を返すこと" do
      cart.add(item)
      expect(cart.total_amount).to eq item.price
    end
  end

  describe "#check_out" do
    let(:balance) { 99999999999 }
    before do
      customer.wallet.deposit(balance)
      # check_out前
      expect(customer.wallet.balance == balance).to eq true
      expect(item.owner == seller).to eq true
      expect(seller.wallet.balance == 0).to eq true

      cart.add(item)
    end
    it "カートの中身（Cart#items）のすべてのアイテムの購入金額が、カートのオーナーのウォレットからアイテムのオーナーのウォレットに移されること" do
      total_amount = cart.total_amount
      cart.check_out
      expect(customer.wallet.balance == (balance - total_amount)).to eq true 
      expect(seller.wallet.balance == total_amount).to eq true 
    end
    it "カートの中身（Cart#items）のすべてのアイテムのオーナー権限が、カートのオーナーに移されること" do
      items = cart.items
      cart.check_out
      expect(items.all?{|item| item.owner == customer }).to eq true
    end
    it "カートの中身（Cart#items）が空になること" do
      expect(cart.items != []).to eq true 
      cart.check_out
      expect(cart.items == []).to eq true 
    end
  end
end
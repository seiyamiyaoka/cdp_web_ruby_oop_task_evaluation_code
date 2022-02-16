require "spec_helper"

RSpec.describe Customer do
  let(:customer) { build(:customer) }
  let(:seller) { build(:seller) }
  let(:item) { build(:item, owner: seller) }

  it "Must inherit from User" do
    expect(Customer.superclass).to eq User
  end

  describe "#initialize" do
    it "Must have @cart with itself as the owner" do
      expect(customer.instance_variable_get(:@cart).owner).to eq customer
    end
  end

  describe "#cart" do
    it "should return a Cart object with itself as owner" do
      cart = customer.cart
      expect(cart.class == Cart).to eq true
      expect(cart.owner == customer).to eq true
    end
    it "'#cart=' must not be defined (using attr_reader)" do
      expect(customer.methods.include?(:cart=)).to eq false
    end
  end
end

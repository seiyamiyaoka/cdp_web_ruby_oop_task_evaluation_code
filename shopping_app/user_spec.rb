require "spec_helper"

RSpec.describe User do
  let(:user) { build(:user) }

  it "must include ItemManager" do
    expect(User.included_modules.include?(ItemManager)).to eq true
  end

  describe "#initialize" do
    it "Must have @name" do
      expect(user.instance_variable_get(:@name)).to be_truthy
    end
    it "must have @wallet with itself as the owner" do
      expect(user.instance_variable_get(:@wallet).owner).to eq user
    end
  end

  describe "#name" do
    let(:name) { "name" }
    let(:user) { build(:seller, name: name) }
    it "To return the string defined in the name attribute" do
      expect(user.name).to eq name
    end
  end

  describe "#name=" do
    let(:name) { "name" }
    before do
      user.name = name
    end
    it "that we can change name" do
      expect(user.name).to eq name
    end
  end

  describe "#wallet" do
    it "should return a Wallet object with itself as the owner" do
      wallet = user.wallet
      expect(wallet.class == Wallet).to eq true
      expect(wallet.owner == user).to eq true
    end
    it "'#wallet=' must not be defined (using attr_reader)" do
      expect(user.methods.include?(:wallet=)).to eq false
    end
  end

end

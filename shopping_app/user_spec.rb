require "spec_helper"

RSpec.describe User do
  let(:user) { build(:user) }

  it "ItemManagerをincludeしていること" do
    expect(User.included_modules.include?(ItemManager)).to eq true
  end

  describe "#initialize" do
    it "@nameを持つこと" do
      expect(user.instance_variable_get(:@name)).to be_truthy
    end
    it "自身がownerとなっている@walletを持つこと" do
      expect(user.instance_variable_get(:@wallet).owner).to eq user 
    end
  end

  describe "#name" do
    let(:name) { "name" }
    let(:user) { build(:seller, name: name) }
    it "name属性に定義されている文字列を返すこと" do
      expect(user.name).to eq name
    end
  end

  describe "#name=" do
    let(:name) { "name" }
    before do
      user.name = name
    end
    it "nameを変更できること" do
      expect(user.name).to eq name
    end
  end

  describe "#wallet" do
    it "自身がownerとなっているWalletオブジェクトを返すこと" do
      wallet = user.wallet
      expect(wallet.class == Wallet).to eq true
      expect(wallet.owner == user).to eq true
    end
    it "'#wallet='は定義されていないこと（attr_readerを使っていること）" do
      expect(user.methods.include?(:wallet=)).to eq false
    end
  end

end
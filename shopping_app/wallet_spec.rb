require "spec_helper"

RSpec.describe Wallet do
  let(:wallet){ build(:wallet, owner: build(:seller)) }

  it "Ownableをincludeしていること" do
    expect(Wallet.included_modules.include?(Ownable)).to eq true
  end

  describe "#initialize" do
    it "@ownerを持つこと" do
      expect(wallet.instance_variable_get(:@owner)).to be_truthy
    end
    it "初期値が0の@balanceを持つこと" do
      expect(wallet.instance_variable_get(:@balance)).to eq 0
    end
  end

  describe "#balance" do
    let(:balance) { 99999999999 }
    before do
      wallet.deposit(balance)
    end
    it "balance属性に定義されている数値を返すこと" do
      expect(wallet.balance).to eq balance
    end
    it "'#balance='は定義されていないこと（attr_readerを使っていること）" do
      expect(wallet.methods.include?(:balance=)).to eq false
    end
  end

  describe "#deposit(amount)" do
    let(:amount) { 99999999999 }
    it "amountとして渡された数値が自身のbalanceに加算されること" do
      original_balance = wallet.balance
      wallet.deposit(amount)
      expect(wallet.balance).to eq (original_balance + amount)
    end
  end
  
  describe "#withdraw(amount)" do
    let(:amount) { 10 }
    before do
      wallet.deposit(100)
    end
    it "amountとして渡された数値を自身のbalanceから減算してその数値を返すこと" do
      original_balance = wallet.balance
      expect(wallet.withdraw(amount)).to eq amount
      expect(wallet.balance).to eq (original_balance - amount)
    end
    context "十分な残高がない場合" do
      let(:amount) { 99999999999 }
      it "nilを返すこと" do
        expect(wallet.withdraw(amount)).to eq nil
      end
    end
  end
end
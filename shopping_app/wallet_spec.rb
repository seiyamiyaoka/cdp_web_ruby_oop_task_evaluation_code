require "spec_helper"

RSpec.describe Wallet do
  let(:wallet){ build(:wallet, owner: build(:seller)) }

  it "must include Ownable" do
    expect(Wallet.included_modules.include?(Ownable)).to eq true
  end

  describe "#initialize" do
    it "To have @owner" do
      expect(wallet.instance_variable_get(:@owner)).to be_truthy
    end
    it "Must have @balance with initial value of 0" do
      expect(wallet.instance_variable_get(:@balance)).to eq 0
    end
  end

  describe "#balance" do
    let(:balance) { 99999999999 }
    before do
      wallet.deposit(balance)
    end
    it "To return the number defined in the balance attribute" do
      expect(wallet.balance).to eq balance
    end
    it "'#balance=' must not be defined (using attr_reader)" do
      expect(wallet.methods.include?(:balance=)).to eq false
    end
  end

  describe "#deposit(amount)" do
    let(:amount) { 99999999999 }
    it 'that the number passed as "amount" will be added to its own balance' do
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
    it 'subtract the number passed as "amount" from its own balance and return that number' do
      original_balance = wallet.balance
      expect(wallet.withdraw(amount)).to eq amount
      expect(wallet.balance).to eq (original_balance - amount)
    end
    context "If there is not enough balance" do
      let(:amount) { 99999999999 }
      it "to return nil" do
        expect(wallet.withdraw(amount)).to eq nil
      end
    end
  end
end

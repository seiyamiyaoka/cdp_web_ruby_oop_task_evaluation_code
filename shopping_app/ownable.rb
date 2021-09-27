require "spec_helper"

RSpec.describe Ownable do
  let(:dummy_class) { Class.new { extend Ownable } }

  describe "#owner" do
    let(:owner) { build(:seller) }
    before do
      dummy_class.owner = owner
    end
    it "owner属性に定義されているオブジェクトを返すこと" do
      expect(dummy_class.owner).to eq owner
    end
  end

  describe "#owner=" do
    let(:owner) { build(:seller) }
    it "ownerを変更できること" do
      expect(dummy_class.owner.nil?).to eq true
      dummy_class.owner = owner
      expect(dummy_class.owner).to eq owner
    end
  end
end
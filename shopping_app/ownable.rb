require "spec_helper"

RSpec.describe Ownable do
  let(:dummy_class) { Class.new { extend Ownable } }

  describe "#owner" do
    let(:owner) { build(:seller) }
    before do
      dummy_class.owner = owner
    end
    it "Return the object defined in the owner attribute." do
      expect(dummy_class.owner).to eq owner
    end
  end

  describe "#owner=" do
    let(:owner) { build(:seller) }
    it "Ability to change owner." do
      expect(dummy_class.owner.nil?).to eq true
      dummy_class.owner = owner
      expect(dummy_class.owner).to eq owner
    end
  end
end

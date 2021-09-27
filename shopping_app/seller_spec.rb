require "spec_helper"

RSpec.describe Seller do
  let(:seller) { build(:seller) }

  it "Userを継承していること" do
    expect(Seller.superclass).to eq User
  end

end
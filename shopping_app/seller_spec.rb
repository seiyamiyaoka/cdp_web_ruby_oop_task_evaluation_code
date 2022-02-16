require "spec_helper"

RSpec.describe Seller do
  let(:seller) { build(:seller) }

  it "User must be inherited." do
    expect(Seller.superclass).to eq User
  end

end

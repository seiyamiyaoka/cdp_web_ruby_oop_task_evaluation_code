require "spec_helper"

RSpec.describe Item do
  let(:item) { build(:item) }

  it "Must include Ownable" do
    expect(Item.included_modules.include?(Ownable)).to eq true
  end
  it "Must have @@instances" do
    expect(Item.class_variable_get(:@@instances)).to be_truthy
  end
  it "@@instances must be an array" do
    expect(Item.class_variable_get(:@@instances).class).to eq Array
  end

  describe "#initialize" do
    it "Must have an @name" do
      expect(item.instance_variable_get(:@name)).to be_truthy
    end
    it "To have @price" do
      expect(item.instance_variable_get(:@price)).to be_truthy
    end
    it "To have @owner" do
      expect(item.instance_variable_get(:@owner)).to be_truthy
    end
    it "To store itself in @@instances" do
      item
      expect(Item.class_variable_get(:@@instances).include?(item)).to eq true
    end
  end

  describe "#name" do
    let(:name) { "name" }
    let(:item) { build(:item, name: name) }
    it "To return the string defined in the name attribute" do
      expect(item.name).to eq name
    end
    it "'#name=' must not be defined (using attr_reader)" do
      expect(item.methods.include?(:name=)).to eq false
    end
  end

  describe "#price" do
    let(:price) { 1 }
    let(:item) { build(:item, price: price) }
    it "To return the number defined in the price attribute" do
      expect(item.price).to eq price
    end
    it "'#price=' must not be defined (using attr_reader)" do
      expect(item.methods.include?(:price=)).to eq false
    end
  end

  describe "#label" do
    it "Must return a hash of { name: its own name, price: its own price }" do
      expect(item.label).to eq({ name: item.name, price: item.price })
    end end
  end

  describe ".all" do
    it "Return @@instances (return all instantiated Item objects)" do
      expect(Item.all).to eq Item.class_variable_get(:@@instances)
    end
  end

end

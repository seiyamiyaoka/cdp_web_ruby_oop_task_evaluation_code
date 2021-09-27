require "spec_helper"

RSpec.describe Item do
  let(:item) { build(:item) }

  it "Ownableをincludeしていること" do
    expect(Item.included_modules.include?(Ownable)).to eq true
  end
  it "@@instancesを持つこと" do
    expect(Item.class_variable_get(:@@instances)).to be_truthy
  end
  it "@@instancesは配列であること" do
    expect(Item.class_variable_get(:@@instances).class).to eq Array
  end

  describe "#initialize" do
    it "@nameを持つこと" do
      expect(item.instance_variable_get(:@name)).to be_truthy
    end
    it "@priceを持つこと" do
      expect(item.instance_variable_get(:@price)).to be_truthy
    end
    it "@ownerを持つこと" do
      expect(item.instance_variable_get(:@owner)).to be_truthy
    end
    it "@@instancesに自身が格納されること" do
      item
      expect(Item.class_variable_get(:@@instances).include?(item)).to eq true
    end
  end

  describe "#name" do
    let(:name) { "name" }
    let(:item) { build(:item, name: name) }
    it "name属性に定義されている文字列を返すこと" do
      expect(item.name).to eq name
    end
    it "'#name='は定義されていないこと（attr_readerを使っていること）" do
      expect(item.methods.include?(:name=)).to eq false
    end
  end

  describe "#price" do
    let(:price) { 1 }
    let(:item) { build(:item, price: price) }
    it "price属性に定義されている数値を返すこと" do
      expect(item.price).to eq price
    end
    it "'#price='は定義されていないこと（attr_readerを使っていること）" do
      expect(item.methods.include?(:price=)).to eq false
    end
  end

  describe "#label" do
    it "{ name: 自身のname, price: 自身のprice }のハッシュを返すこと" do
      expect(item.label).to eq({ name: item.name, price: item.price })
    end
  end

  describe ".all" do
    it "@@instancesを返すこと（インスタンス化されたすべてのItemオブジェクトを返すこと）" do
      expect(Item.all).to eq Item.class_variable_get(:@@instances)
    end
  end

end
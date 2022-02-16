require "spec_helper"

RSpec.describe ItemManager do
  let(:dummy_class) { Class.new { extend ItemManager }

  describe "#items" do
    it "should return all items for which it is the owner" do
      my_item = build(:item, owner: dummy_class)
      expect(dummy_class.items.size == 1).to eq true
      expect(dummy_class.items.first == my_item).to eq true
    end
  end

  describe "#pick_items(number, quantity)" do
    before do
      build_list(:item, 5, name: "item1", price: "100", owner: dummy_class)
      build_list(:item, 5, name: "item2", price: "200", owner: dummy_class)
    end
    it "To return items according to the item number (number) and quantity (quantity)" do
      items = dummy_class.pick_items(0, 3)
      expect(items.size).to eq 3
      expect(items.all?{|item| item.label == items.first.label}).to eq true
    end
    context "If a non-existent item number is specified" do
      it "to return nil" do
        expect(dummy_class.pick_items(999, 1)).to eq nil
      end
    end
    context "If the number of items is greater than or equal to the number of items you own" do
      it "should return nil" do
        expect(dummy_class.pick_items(0, 999)).to eq nil
      end
    end
  end

  describe "#items_list" do
    before do
      build_list(:item, 5, name: "item1", price: "100", owner: dummy_class)
      build_list(:item, 5, name: "item2", price: "200", owner: dummy_class)
    end
    it "To display a list of items owned by the user and their quantity, categorized by label." do
      expected_outpt = <<~EOS
        +----+------+----+----+
        |Number|ItemName|Amount|Quantity|
        +----+------+----+----+
        |0   |item1 |100 |5   |
        |1   |item2 |200 |5   |
        +----+------+----+----+
      EOS
      expect{ dummy_class.items_list }.to output(expected_outpt).to_stdout
    end
  end

end

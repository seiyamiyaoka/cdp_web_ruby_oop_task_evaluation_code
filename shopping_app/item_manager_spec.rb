require "spec_helper"

RSpec.describe ItemManager do
  let(:dummy_class) { Class.new { extend ItemManager } }

  describe "#items" do
    it "自身がownerとなっているアイテム全てを返すこと" do
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
    it "商品番号(number)と個数(quantity)に応じたアイテムを返すこと" do
      items = dummy_class.pick_items(0, 3)
      expect(items.size).to eq 3
      expect(items.all?{|item| item.label == items.first.label}).to eq true
    end
    context "存在しない商品番号を指定された場合" do
      it "nilを返すこと" do
        expect(dummy_class.pick_items(999, 1)).to eq nil
      end
    end
    context "自身の所有する個数以上の個数を指定された場合" do
      it "nilを返すこと" do
        expect(dummy_class.pick_items(0, 999)).to eq nil
      end
    end
  end

  describe "#items_list" do
    before do
      build_list(:item, 5, name: "item1", price: "100", owner: dummy_class)
      build_list(:item, 5, name: "item2", price: "200", owner: dummy_class)
    end
    it "ラベルごとに分類された自身の所有するアイテムとその個数のリストを表示すること" do
      expected_outpt = <<~EOS
        +----+------+----+----+
        |番号|商品名|金額|数量|
        +----+------+----+----+
        |0   |item1 |100 |5   |
        |1   |item2 |200 |5   |
        +----+------+----+----+
      EOS
      expect{ dummy_class.items_list }.to output(expected_outpt).to_stdout
    end
  end
  
end
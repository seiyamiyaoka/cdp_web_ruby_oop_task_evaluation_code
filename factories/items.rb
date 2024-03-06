FactoryBot.define do
  factory :item do
    number { 1 }
    name { "item" }
    price { 1000 }
    owner { build(:seller) }

    initialize_with { new(name, price, owner) }
  end
end

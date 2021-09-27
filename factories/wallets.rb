FactoryBot.define do
  factory :wallet do
    owner {}

    initialize_with { new(owner) }
  end
end
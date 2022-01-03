FactoryBot.define do
  factory :ingredient do
    amount { 100 }
    unit { 'grams' }
    name { 'flour' }
    recipe
  end
end

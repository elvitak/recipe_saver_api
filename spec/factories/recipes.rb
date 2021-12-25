FactoryBot.define do
  factory :recipe do
    title { 'Boiled egg' }
    ingredients { %w[egg water] }
    instructions { ['Take an egg', 'Boil it'] }
  end
end

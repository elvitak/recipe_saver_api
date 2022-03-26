FactoryBot.define do
  factory :recipe do
    title { 'Boiled egg' }
    after(:build) do |recipe|
      recipe.image.attach(
        io: File.open(Rails.root.join('spec', 'fixtures', 'pancakes.jpeg')),
        filename: 'pancakes.jpeg',
        content_type: 'image/jpeg'
      )
    end
  end
end

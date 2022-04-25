FactoryBot.define do
  factory :recipe do
    transient do
      with_image { true }
    end
    title { 'Boiled egg' }

    after(:build) do |recipe, evaluator|
      if evaluator.with_image
        recipe.image.attach(
          io: File.open(Rails.root.join('spec', 'fixtures', 'pancakes.jpeg')),
          filename: 'pancakes.jpeg',
          content_type: 'image/jpeg'
        )
      end
    end
  end
end

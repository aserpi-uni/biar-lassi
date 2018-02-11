FactoryBot.define do
  factory :product do
    enterprise { Enterprise.first || association(:enterprise) }
    active true
    model 'Model'
    description <<~EOS
    A
    multiline
    description
    EOS
    production_year 2018
  end

  factory :second_product, class: Product do
    enterprise { Enterprise.first }
    model 'Model_two'
  end
end

FactoryBot.define do
  factory :problem_thread do
    product { Product.first || association(:product) }
    title 'Title'
    content 'Content'

  end

end
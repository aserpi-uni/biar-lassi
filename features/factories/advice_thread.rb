FactoryBot.define do
  factory :advice_thread do
    product { Product.first || association(:product) }
    title 'Title'
    content 'Content'

  end

end
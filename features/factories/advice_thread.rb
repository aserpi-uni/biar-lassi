FactoryBot.define do
  factory :advice_thread do
    product { Product.first || association(:product) }
    author { Consumer.first || association(:consumer) }
    title 'Advice thread title'
    content 'Advice thread content'
  end
end

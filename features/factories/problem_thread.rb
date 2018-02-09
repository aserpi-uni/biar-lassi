FactoryBot.define do
  factory :problem_thread do
    product { Product.first || association(:product) }
    author { Consumer.first || association(:consumer) }
    employee { association(:problem_operator) }
    title 'Problem Thread title'
    content 'Problem Thread content'
  end
end

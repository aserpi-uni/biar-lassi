FactoryBot.define do
  factory :comment do
    content 'Content of a Comment'

    trait :advice_thread do
      domain { AdviceThread.first || association(:advice_thread) }
    end

    trait :problem_thread do
      domain { ProblemThread.first || association(:problem_thread) }
    end

    trait :consumer do
      author { Consumer.first || association(:consumer) }
    end

    trait :operator do
      author { Employee.where(role: :operator).first }
    end
  end
end

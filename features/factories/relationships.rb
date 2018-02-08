FactoryBot.define do
  factory :problem_thread_relationship, class: Relationship do
    follower { Consumer.first || association(:consumer) }
    followed {ProblemThread.first || association (:problem_thread)}

  end

  factory :advice_thread_relationship, class: Relationship do
    follower { Consumer.first || association(:consumer) }
    followed {AdviceThread.first || association (:advice_thread)}

  end

end
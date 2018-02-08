FactoryBot.define do
  factory :problem_thread_comment_e, class: Comment do
    domain { ProblemThread.first || association(:problem_thread) }
    commentable { Employee.first || association (:employee)}

    content 'Content problem employee'

  end

  factory :problem_thread_comment_c, class: Comment do
    domain { ProblemThread.first || association(:problem_thread) }
    commentable { Consumer.first || association (:consumer)}

    content 'Content problem consumer'

  end

  factory :advice_thread_comment_e, class: Comment do
    domain { AdviceThread.first || association(:advice_thread) }
    commentable { Employee.first || association (:employee)}

    content 'Content advice employee'

  end

  factory :advice_thread_comment_c, class: Comment do
    domain { AdviceThread.first || association(:advice_thread) }
    commentable { Consumer.first || association (:consumer)}

    content 'Content advice consumer'

  end

end
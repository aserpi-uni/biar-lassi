FactoryBot.define do
  factory :enterprise do
    name 'Enterprise_one'
    username_suffix 'enter_one'
  end

  factory :second_enterprise, class: Enterprise do
    name 'Enterprise_two'
    username_suffix 'enter_two'
  end
end
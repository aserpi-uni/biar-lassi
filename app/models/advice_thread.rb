class AdviceThread < ApplicationRecord
  include Threadable
  searchkick callbacks: :async

  enum status: { waiting: 0, evaluating: 1, planned: 2, implemented: 3, rejected: 4 }

  def search_data
    {
      content: content,
      title: title
    }
  end
end

class AdviceThread < ApplicationRecord
  include Threadable
  searchkick callbacks: :async

  def search_data
    {
      content: content,
      title: title
    }
  end
end

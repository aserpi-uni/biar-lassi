class DeleteImageJob < ApplicationJob
  def perform(data)
    Shrine::Attacher.delete(data)
  end
end

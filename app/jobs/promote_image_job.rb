class PromoteImageJob < ApplicationJob
  def perform(data)
    Shrine::Attacher.promote(data)
  end
end

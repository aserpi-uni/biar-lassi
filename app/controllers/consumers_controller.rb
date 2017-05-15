class ConsumersController < ApplicationController
  def index; end

  def show
    @consumer = Consumer.find_by! username: params[:username]
  end
end

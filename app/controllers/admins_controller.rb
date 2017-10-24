class AdminsController < ApplicationController
  def show
    @admin = Admin.find_by! username: params[:username]
  end

  # TODO: def new
end

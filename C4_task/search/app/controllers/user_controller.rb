class UserController < ApplicationController
  def index

  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(params[:user])

  end
  def delete
  end
end

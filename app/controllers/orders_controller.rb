class OrdersController < ApplicationController
  before_action :user_only!, only: [:create]

  def create
  end
end

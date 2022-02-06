class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: ENV["NAME"] , password: ENV["PASSWORD"]
  before_filter :authorize

  def show
    @product_count = Product.count
    @category_count = Category.count
  end
end
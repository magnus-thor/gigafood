class HomeController < ApplicationController
  def index
    @categories = Category.order(:sort_key).all
  end
end

ActiveAdmin.register_page "Add Dishes" do
  menu false

  controller do
    layout 'active_admin'
    def index
      @categories = Category.order(:sort_key).all
      @order = Order.find(params[:id])
    end
  end

  content only: :index do
    render partial: 'index'
  end
end
ActiveAdmin.register_page "Add Products" do
  menu false

  controller do
    layout 'active_admin'

    def index
      @page_title = 'Add Products to order'
      @categories = Category.order(:sort_key).all
      @cutlery = Product.cutlery.first
      @order = Order.find(params[:id])
    end
  end

  content only: :index do
    render partial: 'index'
  end
end
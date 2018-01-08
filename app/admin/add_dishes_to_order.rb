ActiveAdmin.register_page "Add Dishes" do
  menu false

  controller do
    layout 'active_admin'
    def index
      @order = Order.find(params[:id])
      # binding.pry
    end
  end

  content only: :index do
    render partial: 'index'
  end
end
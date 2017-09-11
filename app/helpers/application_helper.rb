module ApplicationHelper
  def get_order
    if ShoppingCart.exists?(session[:order_id])
      order = ShoppingCart.find(session[:order_id])
    else
      order = ShoppingCart.create
      session[:order_id] = order.id
    end

    order
  end
end

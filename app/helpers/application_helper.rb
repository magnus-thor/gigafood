module ApplicationHelper
  def get_order
    if Order.exists?(session[:order_id])
      order = Order.find(session[:order_id])
    else
      order = Order.create
      session[:order_id] = order.id
    end

    order
  end
end

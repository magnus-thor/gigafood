class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def get_order
    if Order.exists?(session[:order_id])
      order = Order.find(session[:order_id])
    else
      order = Order.create
      session[:order_id] = order.id
      order.update(status: 'pending')
    end
    order
  end
end

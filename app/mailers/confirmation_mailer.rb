class ConfirmationMailer < ApplicationMailer
  default from: 'noreply@gigafood.se'

  def review_email(order)
    @order = order
    mail(to: @order.billing_email, subject: 'Gigafood Order')
  end

  def confirmation_email(order)
    @order = order
    @url = 'http://example.com/confirmation'
    @order.status = 'approved'
      mail(to: @order.billing_email, subject: 'Confirmation from Gigafood')
  end

  def cancelation_email(order)
    @order = order
    @url = "http://example.com/cancelation"
    @order.status = 'canceled'
    mail(to: @order.billing_email, subject: 'Cancelation from Gigafood')
  end

  def move_by_bike_email(email, order)
    @order = order
    mail(to: email, subject: 'Request for delivery from Gigafood')
  end
end

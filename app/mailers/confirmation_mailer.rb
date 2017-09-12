class ConfirmationMailer < ApplicationMailer
  default from: 'noreply@gigafood.se'

  def confirmation_email(order)
    @order = order
    @url = 'http://example.com/confirmation'
    @order.status = 'approved'
      mail(to: @order.email, subject: 'Confirmation from Gigafood')
  end

  def cancelation_email(order)
    @order = order
    @url = "http://example.com/cancelation"
    @order.status = 'canceled'
    mail(to: @order.email, subject: 'Cancelation from Gigafood')
  end
end

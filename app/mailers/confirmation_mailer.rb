class ConfirmationMailer < ApplicationMailer
  default from: 'noreply@gigafood.se'

  # before_action :attach_image

  def review_email(order)
    @order = order
    # mail(to: @order.billing_email, subject: 'Gigafood Order')
    mail(to: @order.billing_email, subject: 'Gigafood Order') do |format|
      format.mjml
    end
  end

  def confirmation_email(order)
    # attachments.inline['gigafood_logo.png'] = File.read('app/assets/images/gigafood_logo.png')
    @order = order
    @url = 'http://example.com/confirmation'
    @order.status = 'approved'
    # mail(to: @order.billing_email, subject: 'Confirmation from Gigafood')
    mail(to: @order.billing_email, subject: 'Confirmation from Gigafood') do |format|
      format.mjml
    end
  end

  def cancelation_email(order)
    @order = order
    @url = "http://example.com/cancelation"
    @order.status = 'canceled'
    # mail(to: @order.billing_email, subject: 'Cancelation from Gigafood')
    mail(to: @order.billing_email, subject: 'Cancelation from Gigafood') do |format|
      format.mjml
    end
  end

  def move_by_bike_email(email, order)
    @order = order
    mail(to: email, subject: 'Request for delivery from Gigafood')
  end

  def attach_image
    attachments.inline['gigafood_logo.png'] = File.read('app/assets/images/gigafood_logo.png')
  end
end

require "rails_helper"

RSpec.describe ConfirmationMailer, type: :mailer do
  describe 'confirmation' do
    let(:order) { FactoryGirl.create(:order, billing_name: 'Volvo AB', status: 'approved', billing_email: 'customer@test.com') }
    let(:mail) { ConfirmationMailer.confirmation_email(order) }

    it 'renders the subject' do
      expect(mail.subject).to eql('Confirmation from Gigafood')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eql([order.billing_email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eql(['noreply@gigafood.se'])
    end

    it 'render the customer name' do
      expect(mail.body.encoded).to match(order.billing_name)
    end
  end
end

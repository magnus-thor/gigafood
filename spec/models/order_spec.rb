require 'rails_helper'

RSpec.describe Order, type: :model do
  subject { create(:order) }

  it { is_expected.to have_db_column :id }
  it { is_expected.to have_db_column :delivery_date }
  it { is_expected.to have_db_column :delivery_method }
  it { is_expected.to have_db_column :delivery_name }
  it { is_expected.to have_db_column :delivery_address }
  it { is_expected.to have_db_column :delivery_postal_code }
  it { is_expected.to have_db_column :delivery_city }
  it { is_expected.to have_db_column :delivery_floor }
  it { is_expected.to have_db_column :delivery_door_code }
  it { is_expected.to have_db_column :delivery_contact_name }
  it { is_expected.to have_db_column :delivery_contact_phone_number }
  it { is_expected.to have_db_column :billing_name }
  it { is_expected.to have_db_column :billing_company }
  it { is_expected.to have_db_column :billing_org_nr }
  it { is_expected.to have_db_column :billing_address }
  it { is_expected.to have_db_column :billing_postal_code }
  it { is_expected.to have_db_column :billing_city }
  it { is_expected.to have_db_column :billing_phone }
  it { is_expected.to have_db_column :billing_email }
  it { is_expected.to have_db_column :allergies }
  it { is_expected.to have_db_column :boxes }
  it { is_expected.to have_db_column :status }

  describe 'Associations' do
    it { is_expected.to have_many :attachments }
  end

  describe '#set_payment_due_date' do
    before { subject.set_payment_due_date }

    it 'sets date to 10 days' do
      expect(subject.due_date).to eq Date.today + 10
    end

    it 'is a TimeWithZone object' do
      expect(subject.due_date.class).to eq ActiveSupport::TimeWithZone
    end

  end

  describe '#has_invoice?' do
    let(:item) { create(:dish)}

    before do
      subject.add(item, item.price, 1)
      PdfGeneratorService.new(subject).generate_invoice
    end

    it 'returns true if invoice exists' do
      expect(subject.has_invoice?).to eq true
    end

  end

  describe '#has_menu?' do
    let(:item) { create(:dish)}

    before do
      subject.add(item, item.price, 1)
      PdfGeneratorService.new(subject).generate_menu
    end

    it 'returns true if menu exists' do
      expect(subject.has_menu?).to eq true
    end

  end

  describe 'Returns false if order is not submitted.' do

    it 'returns false' do
      expect(subject.submitted?).to eq false
    end

  end

  describe 'Returns true if order is submitted and has required attributes.' do
    let(:item) { create(:dish)}

    before 'Set order to submitted and add required data' do
      subject.add(item, item.price, 1)

      order_values = {delivery_method: 'delivery', delivery_name: 'Big corp', billing_name: 'Big corp 111',
                      billing_company: 'Big corp 222', billing_org_nr: '19900101-1234', billing_address: 'Street 42',
                      billing_postal_code: '123 45', billing_city: 'Town', billing_phone: '555 123 45 66',
                      billing_email: 'invoce@bigcorp.com', status: 'submitted'}

      subject.update(order_values)
    end

    it 'returns true if order is submitted' do
      expect(subject.submitted?).to eq true
    end

    it 'has a billing_company' do
      is_expected.to validate_presence_of(:billing_company)
    end

    it 'has a billing_org_nr' do
      is_expected.to validate_presence_of(:billing_org_nr)
    end

    it 'has a billing_address' do
      is_expected.to validate_presence_of(:billing_address)
    end

    it 'has a billing_postal_code' do
      is_expected.to validate_presence_of(:billing_postal_code)
    end

    it 'has a billing_city' do
      is_expected.to validate_presence_of(:billing_city)
    end

    it 'has a billing_phone' do
      is_expected.to validate_presence_of(:billing_phone)
    end

    it 'has a billing_email' do
      is_expected.to validate_presence_of(:billing_email)
    end

    # it 'has a delivery_method' do
    #   is_expected.to validate_presence_of(:delivery_method)
    # end
    #
    # it 'has a billing_name' do
    #   is_expected.to validate_presence_of(:billing_name)
    # end

  end

end


#order_params = {allergies: 'peanuts', delivery_method: 'delivery', delivery_name: 'Big corp',
#                delivery_address: 'Street 42', delivery_postal_code: '123 45', delivery_city: 'Town',
#                delivery_floor: '3', delivery_door_code: '1234', delivery_contact_name: 'John Doe',
#                delivery_contact_phone_number: '555 123 45 66', billing_name: 'Big corp 111',
#                billing_company: 'Big corp 222', billing_org_nr: '19900101-1234', billing_address: 'Street 42',
#                billing_postal_code: '123 45', billing_city: 'Town', billing_phone: '555 123 45 66',
#                billing_email: 'invoce@bigcorp.com', status: 'submitted'}

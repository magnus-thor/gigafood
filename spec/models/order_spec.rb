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

  describe 'Validations' do
    let!(:attributes_to_validate) { [:billing_company,
                                     :billing_org_nr,
                                     :billing_address,
                                     :billing_postal_code,
                                     :billing_city,
                                     :billing_phone,
                                     :billing_email] }
    context 'order is NOT submitted' do
      it 'skips validation of billing attributes' do
        attributes_to_validate.each do |attribute|
          is_expected.to_not validate_presence_of(attribute)
        end
      end

    end

    context 'order is submitted' do
      before { allow(subject).to receive(:submitted?).and_return(true) }

      it 'validates billing attributes' do
        attributes_to_validate.each do |attribute|
          is_expected.to validate_presence_of(attribute)
        end
      end
    end
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
    let(:item) { create(:product) }

    before do
      subject.add(item, item.price, 1)
      PdfGeneratorService.new(subject).generate_invoice
    end

    it 'returns true if invoice exists' do
      expect(subject.has_invoice?).to eq true
    end

  end

  describe '#has_menu?' do
    let(:item) { create(:product) }

    before do
      subject.add(item, item.price, 1)
      PdfGeneratorService.new(subject).generate_menu
    end

    it 'returns true if menu exists' do
      expect(subject.has_menu?).to eq true
    end
  end

  describe '#submitted?' do
    describe 'order is not submitted' do
      it 'returns false' do
        expect(subject.submitted?).to eq false
      end
    end

    describe 'order is submitted' do
      let(:item) { create(:product) }

      before do
        subject.add(item, item.price, 1)

        order_values = {delivery_method: 'delivery',
                        delivery_name: 'Big corp',
                        billing_name: 'Big corp 111',
                        billing_company: 'Big corp 222',
                        billing_org_nr: '19900101-1234',
                        billing_address: 'Street 42',
                        billing_postal_code: '123 45',
                        billing_city: 'Town',
                        billing_phone: '555 123 45 66',
                        billing_email: 'invoce@bigcorp.com',
                        status: 'submitted'}

        subject.update(order_values)
      end

      it 'returns true' do
        expect(subject.submitted?).to eq true
      end
    end
  end
end



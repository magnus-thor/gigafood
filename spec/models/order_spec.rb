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
end

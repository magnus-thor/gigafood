require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  it { is_expected.to have_db_column :owner_id }
  it { is_expected.to have_db_column :owner_type }
  it { is_expected.to have_db_column :quantity }
  it { is_expected.to have_db_column :item_id }
  it { is_expected.to have_db_column :item_type }
  it { is_expected.to have_db_column :price_cents }
  it { is_expected.to have_db_column :price_currency }
  it { is_expected.to have_db_column :created_at }
  it { is_expected.to have_db_column :updated_at }

  describe '#price.currency' do
    subject { create(:order_item)}

    it 'is set to SEK' do
      expect(subject.price.currency.iso_code).to eq 'SEK'
    end

    it 'has a symbol of "kr"' do
      expect(subject.price.currency.symbol).to eq 'kr'
    end

    it 'puts currency symbol after value' do
      expect(subject.price.currency.symbol_first).to eq false
    end
  end
end

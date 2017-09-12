require 'rails_helper'

RSpec.describe Order, type: :model do
  it { is_expected.to have_db_column :id }
  it { is_expected.to have_db_column :name }
  it { is_expected.to have_db_column :description }
  it { is_expected.to have_db_column :price }
  it { is_expected.to have_db_column :order_date }
  it { is_expected.to have_db_column :delivery_date }
  it { is_expected.to have_db_column :address }
  it { is_expected.to have_db_column :phone }
  it { is_expected.to have_db_column :allergies }
  it { is_expected.to have_db_column :created_at }
  it { is_expected.to have_db_column :updated_at }
  it { is_expected.to have_db_column :boxes }
  it { is_expected.to have_db_column :status }
  it { is_expected.to have_db_column :email }
end

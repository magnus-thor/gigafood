require 'rails_helper'

RSpec.describe Order, type: :model do
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
end

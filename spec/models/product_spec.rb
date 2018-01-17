require 'rails_helper'

RSpec.describe Product, type: :model do
  it 'should have valid Factory' do
    expect(FactoryGirl.create(:product)).to be_valid
  end

  it { is_expected.to have_db_column :id }
  it { is_expected.to have_db_column :name}
  it { is_expected.to have_db_column :description}
  it { is_expected.to have_db_column :price }
end

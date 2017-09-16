require 'rails_helper'

RSpec.describe Translation, type: :model do
  it 'should have valid Factory' do
    expect(FactoryGirl.create(:translation)).to be_valid
  end

  it { is_expected.to have_db_column :id }
  it { is_expected.to have_db_column :key }
  it { is_expected.to have_db_column :value }
  it { is_expected.to have_db_column :locale }
  it { is_expected.to have_db_column :interpolations }
  it { is_expected.to have_db_column :is_proc }

  it { is_expected.to validate_presence_of :key }
  it { is_expected.to validate_presence_of :value }
  it { is_expected.to validate_presence_of :locale }




end

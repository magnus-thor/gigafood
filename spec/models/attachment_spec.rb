require 'rails_helper'

RSpec.describe Attachment, type: :model do
  it 'should have valid Factory' do
    expect(FactoryGirl.create(:attachment)).to be_valid
  end

  it { is_expected.to have_db_column :id }
  it { is_expected.to have_db_column :file_type }

  describe 'Attachment' do
    it { is_expected.to have_attached_file :file}

    it { is_expected.to have_db_column(:file_file_name).of_type(:string) }
    it { is_expected.to have_db_column(:file_content_type).of_type(:string) }
    it { is_expected.to have_db_column(:file_file_size).of_type(:integer) }
    it { is_expected.to have_db_column(:file_updated_at).of_type(:datetime) }
  end

  describe 'Associations' do
    it { is_expected.to belong_to :order }
  end
end

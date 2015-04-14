require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'admin?' do
    context 'user is an admin' do
      it 'returns true' do
        admin = FactoryGirl.create(:admin_user)
        expect(admin).to be_admin
      end
    end
    context 'user is not an admin' do
      it 'returns false' do
        user = FactoryGirl.create(:user)
        expect(user).to_not be_admin
      end
    end
  end
end

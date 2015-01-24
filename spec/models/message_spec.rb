require 'rails_helper'

describe Message, :type => :model do
  describe '#user_id' do
    it { should validate_presence_of(:user_id) }
  end

  describe '#group_id' do
    it { should validate_presence_of(:group_id) }
  end

  describe '#content' do
    it { should validate_presence_of(:content) }
  end
end

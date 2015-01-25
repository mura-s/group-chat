require 'rails_helper'

describe Group, :type => :model do
  describe '#name' do
    it { should validate_presence_of(:name) }
    it { should ensure_length_of(:name).is_at_most(20) }
  end

  describe 'destroyした時' do
    it 'messageも一緒にdestroyされる' do
      group = create(:group_with_user_and_messages)
      expect(Message.where(group_id: group.id)).to exist
      group.destroy
      expect(Message.where(group_id: group.id)).not_to exist
    end
  end
end

require 'rails_helper'

describe Group, :type => :model do
  describe '#name' do
    it { should validate_presence_of(:name) }
    it { should ensure_length_of(:name).is_at_most(20) }
  end
end

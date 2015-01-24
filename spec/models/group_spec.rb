require 'rails_helper'

describe Group, :type => :model do
  describe '#name' do
    it { should validate_presence_of(:name) }
  end
end

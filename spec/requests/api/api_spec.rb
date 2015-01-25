require'rails_helper'

describe 'API', type: :request do
  describe 'groups' do
    it 'メンバー一覧を返す' do
      group = create(:group)
      user1 = create(:user)
      user2 = create(:user)
      group.users << [user1, user2]

      login(user1)
      get "/api/groups/#{group.id}/members"

      expect(response).to have_http_status(:success)

      json = JSON.parse(response.body)
      expect(json['members'].first['id']).to eq user1.id
      expect(json['members'].first['name']).to eq user1.name
      expect(json['members'].second['id']).to eq user2.id
      expect(json['members'].second['name']).to eq user2.name
    end
  end
end

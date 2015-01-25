require 'rails_helper'

describe ChatsController, :type => :controller do
  describe "GET #index" do
    context "未ログインのユーザがアクセスした時" do
      before { get :index }

      it 'ログインページを表示すること' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "ログインユーザがアクセスした時" do
      before do
        @user = create(:user_with_group)
        sign_in(:user, @user)
        get :index
      end

      it '@userと@groupsに、それぞれログインユーザと所属グループを格納していること' do
        expect(assigns(:user)).to eq @user
        expect(assigns(:groups)).to eq @user.groups.all
      end

      it 'indexテンプレートをrenderすること' do
        expect(response).to render_template :index
      end

      it 'ステータスコード200を返すこと' do
        expect(response.status).to eq(200)
      end
    end
  end
end

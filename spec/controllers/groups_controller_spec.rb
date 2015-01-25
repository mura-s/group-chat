require 'rails_helper'

describe GroupsController, :type => :controller do

  before do
    sign_in :user, create(:user)
  end

  describe "GET #new" do
    it "@groupに新規groupオブジェクトが格納されていること" do
      get :new
      expect(assigns(:group)).to be_a_new(Group)
    end
  end

  describe "POST #create" do
    context "有効な属性の場合" do
      it "データベースに新しいグループを保存すること" do
        expect { post :create, group: attributes_for(:group) }.to change(Group, :count).by(1)
      end

      it "chats#indexにリダイレクトすること" do
        post :create, group: attributes_for(:group)
        expect(response).to redirect_to(chats_index_path)
      end
    end

    context "無効な属性の場合" do
      it "データベースに新しいグループを保存しないこと" do
        expect do
          post :create, group: attributes_for(:invalid_group)
        end.not_to change(Group, :count)
      end

      it "newテンプレートを再表示すること" do
        post :create, group: attributes_for(:invalid_group)
        expect(response).to render_template(:new)
      end
    end
  end

end

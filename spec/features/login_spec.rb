require 'rails_helper'

feature 'ログイン' do
  background do
    @user = create(:user_with_group)
  end

  scenario '成功するケース' do
    login(@user)

    expect(page.current_path).to eq chats_index_path
    expect(page).to have_content 'ログインしました。'
  end

  scenario '失敗するケース' do
    @user.password = nil
    login(@user)

    expect(page.current_path).to eq user_session_path
    expect(page).to have_content 'メールアドレスまたはパスワードが無効です。'
  end
end

require 'rails_helper'

feature 'ログイン' do
  background do
    @user = create(:user_with_group)
  end

  scenario '成功するケース' do
    visit root_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Log in'

    expect(page.current_path).to eq chats_index_path
    expect(page).to have_content 'ログインしました。'
  end

  scenario '失敗するケース' do
    visit root_path
    fill_in 'Email', with: @user.email
    click_button 'Log in'

    expect(page.current_path).to eq user_session_path
    expect(page).to have_content 'メールアドレスまたはパスワードが無効です。'
  end
end

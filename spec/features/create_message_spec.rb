require 'rails_helper'

feature 'ユーザがメッセージを投稿する', js: true do
  background do
    @user = create(:user_with_group)
    login(@user)
  end

  scenario 'メッセージ入力し送信すると、タイムラインにメッセージが表示される' do
    click_link @user.groups.first.name
    fill_in 'message-post-area', with: 'test message'
    click_button '送信'

    expect(page).to have_content('test message')
    expect(Message.where(user_id: @user.id)).to exist
  end

end


module LoginMacros
  module Feature
    def login(user)
      visit root_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Log in'
    end
  end

  module Request
    include Warden::Test::Helpers
    def login(user)
      login_as(user, scope: :user)
    end
  end
end

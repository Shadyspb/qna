require 'rails_helper'

feature 'User sign out', %q{
In order to finish session on website
I as user
Want to be able to sign out
} do

  given(:user) { create(:user) }

  scenario 'Signed in user logout' do
    sign_in(user)
    click_on 'Logout'

    expect(page).to have_content 'Signed out successfully.'
  end
end

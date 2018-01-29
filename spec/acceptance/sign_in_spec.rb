require 'rails_helper'

feature 'User sign in', %q{
  In order to be able ask question
  As an User
  I want to be able to sign
} do

  given (:user) { create(:user) }

  scenario 'Refistered user try to sign in' do
    sign_in(user)

    expect(page).to have_content 'Signed in successfully.'
    expect(current_path).to eq root_path
  end

  scenario 'Non-registred user try sign in' do
    visit new_user_session_path
    fill_in 'Email', with: 'admin@test.com'
    fill_in 'Password', with: '12345678'
    click_on 'Log in'

    expect(page).to have_content 'Invalid Email or password.'
    expect(current_path).to eq new_user_session_path
  end

end

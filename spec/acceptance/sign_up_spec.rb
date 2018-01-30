require 'rails_helper'

feature 'User sign up', %q{
  In order to be able ask questions and post answers
  As an User
  I want to be able to sign up
} do

  scenario 'User sign up with valid attributes' do
    visit new_user_registration_path

    fill_in 'Email', with: 'user@test.com'
    fill_in 'Password', with: '12345678'
    fill_in 'Password confirmation', with: '12345678'
    click_on 'Sign up'

    expect(page).to have_content 'Welcome! You have signed up successfully.'
    expect(page).to have_link 'Logout'
  end

  scenario 'User sign up with invalid attributes' do
    visit new_user_registration_path

    fill_in 'Email', with: '123'
    fill_in 'Password', with: '12345678'
    fill_in 'Password confirmation', with: '12345678'
    click_on 'Sign up'

    expect(page).to_not have_link 'Logout'
  end
end

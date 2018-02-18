require_relative 'acceptance_helper'

feature 'Create question', %q{
  In order to get answer from community
  As an quthenticated user
  I want to be able ask questions
} do

  given (:user) { create(:user) }

  scenario 'Authenticated user create the question' do
    sign_in(user)

    visit questions_path
    click_on 'Ask question'
    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'text text'
    click_on 'Create'

    expect(page).to have_content 'Test question'
    expect(page).to have_content 'text text'
  end

  scenario 'with invalid attributes' do
    sign_in(user)
    visit questions_path
    click_on 'Ask question'
    fill_in 'Title', with: ''
    fill_in 'Body', with: ''
    click_on 'Create'

    expect(page).to have_content "Title can't be blank"
    expect(page).to have_content "Body can't be blank"
  end

  scenario 'Non-authenticated user ties to create question' do
    visit questions_path
    click_on 'Ask question'

    expect(page).to_not have_content 'Ask question'
  end

end

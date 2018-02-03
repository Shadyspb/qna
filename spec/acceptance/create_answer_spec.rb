require 'rails_helper'

feature 'Create answer', %q{
  In order to help someone problem
  As a user
  I want to be able to answer their question
} do
  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }


  scenario 'User create answer with valid attributes' do
    sign_in(user)
    visit question_path(question)

    fill_in 'Your Answer', with: 'Answer for the question'
    click_on 'Answer'

    expect(page).to have_content 'Your Answer created successfully'
    expect(page).to have_content 'Answer for the question'
  end

  scenario 'User create answer with invalid attributes' do
    sign_in(user)
    visit question_path(question)

    fill_in 'Your Answer', with: ' '
    click_on 'Answer'

    expect(page).to have_content "Answer not create"
    expect(page).to have_content "Body can't be blank"
  end

  scenario 'Non-authenticated user create answer' do
    visit question_path(question)

    expect(page).to_not have_content 'Your Answer'
    expect(page).to_not have_content 'Answer'
  end
end

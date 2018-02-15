require_relative 'acceptance_helper'

feature 'Create answer', %q{
  In order to help someone problem
  As a user
  I want to be able to answer their question
} do
  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }


  scenario 'User create answer with valid attributes', js: true do
    sign_in(user)
    visit question_path(question)

    fill_in 'Your Answer', with: 'Answer for the question'
    click_on 'Answer'

    within '.answers' do
      expect(page).to have_content 'Answer for the question'
    end
    expect(current_path).to eq question_path(question)
  end

  scenario 'User create answer with invalid attributes', js: true do
    sign_in(user)
    visit question_path(question)

    fill_in 'Your Answer', with: ' '
    click_on 'Answer'

    expect(page).to have_content "Body can't be blank"
  end

  scenario 'Non-authenticated user create answer', js: true do
    visit question_path(question)

    expect(page).to_not have_content 'Your Answer'
    expect(page).to_not have_content 'Answer'
  end

  context 'multiple users' do
    scenario 'All users view new answer dynamically', js: true do

      Capybara.using_session('user') do
        sign_in(user)
        visit question_path(question)
        fill_in 'answer_body', with: 'Answer test of question test'
        click_on 'Post'
        expect(page).to have_content 'Answer test of question test'
      end

      Capybara.using_session('guest') do
        visit question_path(question)
        expect(page).to have_content 'Answer test of question test'
      end
    end
  end
end

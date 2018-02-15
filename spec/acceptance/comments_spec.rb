require_relative 'acceptance_helper'

feature 'Comments', %q{
  In order to discuss about question/answer
  As an autenfication user
  I want to commented question/answer
} do

  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, user: user, question: question) }

  describe 'Question coments' do
    scenario 'non-authorized user cant add a comment' do
      visit question_path(question)
      within '#question' do
        expect(page).to_not have_content("Add comment")
        expect(page).to_not have_css '.comment_form'
      end
    end
  end

  describe 'Answer coments' do
    scenario 'non-authorized user cant add a comment' do
      visit question_path(question)
      within '.answers' do
        expect(page).to_not have_content("Add comment")
        expect(page).to_not have_css '.comment_form'
      end
    end
  end

  describe 'Multiple users' do
    scenario 'All users view new comment for question dynamically', js: true do
      Capybara.using_session('user') do
        sign_in(user)
        visit question_path(question)
        within '#question' do
          fill_in 'comment_body', with: 'My new comment for question about testing'
          click_on 'Add comment'
          sleep(6)
        end
      end

      Capybara.using_session('guest') do
        visit question_path(question)
        expect(page).to have_content("My new comment for question about testing")
      end
    end

    scenario 'All users view new comment for answer dynamically', js: true do
      Capybara.using_session('user') do
        sign_in(user)
        visit question_path(question)
        within '.answers' do
          fill_in 'comment_body', with: 'My new comment for question about testing'
          click_on 'Add comment'
          sleep(5)
        end
      end

      Capybara.using_session('guest') do
        visit question_path(question)
        expect(page).to have_content("My new comment for question about testing")
      end
    end
  end
end 

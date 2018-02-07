require_relative 'acceptance_helper'

feature 'Edit question', %q{
In order to fix some errors or typos in a question
as a user and an its author
I want to be able to edit the question
} do

  given(:author) { create(:user) }
  given(:not_author) { create(:user) }
  given(:question) {create(:question, user: author)}

  scenario 'A non-authenticated user cannot see edit link' do
    visit question_path(question)
    within '.question' do
      expect(page).to_not have_link 'Edit'
    end
  end

  describe 'An authenticated user' do
    scenario 'Not an author cannot see edit link' do
      sign_in(not_author)

      visit question_path(question)
      within '.question' do
        expect(page).to_not have_link 'Edit'
      end
    end
    scenario 'Author can see edit link' do
      sign_in(author)

      visit question_path(question)
      within '.question' do
        expect(page).to have_link 'Edit'
      end
    end
    scenario 'Author tries edit his/her question with valid params', js: true do
      sign_in(author)
      visit question_path(question)

      within '.question' do
        click_on 'Edit Question'
        fill_in 'Title', with: 'edited title'
        fill_in 'Question', with: 'edited question'
        click_on 'Save'

        expect(page).to_not have_content question.body
        expect(page).to have_content 'edited question'
        expect(page).to_not have_selector 'textarea'
      end
    end
  end
end

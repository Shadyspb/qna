require_relative 'acceptance_helper'

feature 'Delete answer', %q{
In order to delete outdated or incorrect answer
As an authenticated user and an author of the answer
I want to be able to delete answer to a question
} do

  given(:author) { create(:user) }
  given(:not_author) { create(:user) }
  given(:question) { create(:question, user: author) }
  given!(:answer) { create(:answer, question: question, user: author) }

  scenario 'The author question delete it', js: true do
    sign_in(author)

    visit question_path(question)
    accept_alert do
      click_on 'Delete Answer'
      expect(page).to_not have_content answer.body
    end
  end

  scenario 'Not author cant delete answer' do
    sign_in(not_author)

    visit question_path(question)
    expect(page).to_not have_link 'Delete Answer'
  end

  scenario 'Non-authenticated user cant delete answer' do
    visit question_path(question)
    expect(page).to_not have_link 'Delete Answer'
  end
end

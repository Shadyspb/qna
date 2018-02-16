require_relative 'acceptance_helper'


feature 'Delete question', %q{
In order to delete question
As an authenticated user and an author of the question
I want to be able to delete question
} do

  given(:author) { create(:user) }
  given(:not_author) { create(:user) }
  given(:question) {create(:question, user: author)}

  scenario 'The author question delete it' do
    sign_in(author)

    visit question_path(question)
    click_on 'Delete Question'
    expect(page).to_not have_content question.title
    expect(page).to_not have_content question.body
  end

  scenario 'Not author cant delete question' do
    sign_in(not_author)

    visit question_path(question)

    expect(page).to_not have_link 'Delete Question'
  end

  scenario 'Non-authenticated user cant delete question' do
    visit question_path(question)

    expect(page).to_not have_link 'Delete Question'
  end
end

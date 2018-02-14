require_relative 'acceptance_helper'

feature 'Votings, votes', %q{
  In order to give community chance to select more infomational answer/question
  As an autenfication user and not owner of answer/question
  I want to votes for foreign question/answer
} do
  given(:user) { create(:user) }
  given(:author) { create(:user) }
  given(:question) { create(:question, user: author) }
  given!(:author_answer) { create(:answer, user: author, question: question) }
  given!(:user_answer) { create(:answer, user: user, question: question) }
  given(:question_with_vote) { create(:question_with_voting, user: author) }

  describe 'Question vote' do
    before do
      sign_in(user)
      visit question_path(question)
    end

    scenario 'non-author user can vote positive', js: true do
      within '#question' do
        click_on '+'
        expect(page).to have_content '1'
      end
    end

    scenario 'non-author user can vote negative',js: true do
      within '#question' do
        click_on '-'
        expect(page).to have_content(-1)
      end
    end

    scenario 'non-author user can change his vote', js: true do
      within '#question' do
        click_on '+'
        click_on 'reset'
        click_on '-'
        expect(page).to have_content(-1)
      end
    end

    scenario 'non-author user cant vote positive/negative double', js: true do
      within '#question' do
        visit question_path(question_with_vote)
        expect(page).to_not have_content("+")
        expect(page).to_not have_content("-")
      end
    end
  end

  describe 'Answer vote' do
    before do
      sign_in(user)
      visit question_path(question)
    end
    scenario 'non-author user can vote positive', js: true do
      within "#answer-id-#{author_answer.id}" do
        click_on '+'
        expect(page).to have_content("1")
      end
    end

    scenario 'non-author user can vote negative', js: true do
      within "#answer-id-#{author_answer.id}" do
        click_on '-'
        expect(page).to have_content("-1")
      end
    end

    scenario 'non-author user can change his vote', js: true do
      within "#answer-id-#{author_answer.id}" do
        click_on '-'
        click_on 'reset'
        expect(page).to have_content("0")
        click_on '+'
        expect(page).to have_content("1")
      end
    end

    scenario 'non-author user cant vote positive/negative double', js: true do
      within "#answer-id-#{author_answer.id}" do
        click_on '-'
        expect(page).to_not have_content("+")
        expect(page).to_not have_content("-")
      end
    end
  end

  scenario 'author cant vote for his question', js: true do
      sign_in(author)
      visit question_path(question)
      within '#question' do
        expect(page).to_not have_css '.vote_up'
        expect(page).to_not have_css '.vote_down'
      end
    end

  scenario 'author cant vote for his answer', js: true do
      sign_in(author)
      visit question_path(question)
      within "#answer-id-#{author_answer.id}" do
        expect(page).to_not have_content("-")
      end
    end

  scenario 'non-autorized user cant votes' do
    visit question_path(question)
    within '#question' do
      expect(page).to_not have_content("+")
      expect(page).to_not have_content("-")
    end
  end
  scenario 'All users can view sum voting' do
    visit question_path(question)
    within '#question' do
      expect(page).to have_css '.vote_score'
    end
  end
end

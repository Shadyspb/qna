require_relative 'acceptance_helper'

feature 'Add files to answer', %q{
In order to illustreate my answer
As an author the answers
I'd like to be able to attach files'
} do

given(:user) { create (:user) }
givem(:question) {create(:question)}

background do
    sign_in(user)
    visit new_question_path(question)
  end

  scenario 'User adds file when asks question' do
    fill_in 'Your answer', with: 'My answer'
    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
    click_on 'Create'

    within '.answers' do
      expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
    end
  end
end
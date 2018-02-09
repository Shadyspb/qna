require_relative 'acceptance_helper'

feature 'Add files to question', %q{
In order to illustreate my question
As an author the question
I'd like to be able to attach files'
} do

given(:user) { create (:user) }

background do
    sign_in(user)
    visit new_question_path
    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'text text'
  end

  scenarion 'User adds file when asks question' do
    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
    click_on 'Create'

    expect(page).to have_content 'spec_helper.rb'
  end
end

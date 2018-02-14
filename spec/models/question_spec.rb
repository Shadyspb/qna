require 'rails_helper'

RSpec.describe Question, type: :model do
  it { should have_many(:answers).dependent(:destroy) }
  it { should have_many :attachments}
  it { should validate_presence_of :title }
  it { should validate_presence_of :body }
  it { should belong_to(:user) }
  it { should have_many(:votes)}

  it {should accept_nested_attributes_for :attachments}

  let(:question) { create(:question, user: user) }
  let(:user) { create(:user) }

  describe '#vote_score' do
    it 'get vote sum score' do
      question.vote_up(user)
      expect(question.vote_score).to eq 1
    end
  end
  describe '#vote_up' do
    it 'add a new positive voting to question' do
      expect(question.votes).to include(question.vote_up(user))
    end

    it 'check assosiation new positive voting with user' do
      expect(user.votes).to include(question.vote_up(user))
    end

    it 'changes vote score of question by 1' do
      vote = question.vote_up(user)
      expect(question.vote_score).to eq 1
    end
  end

  describe '#vote_down' do
    it 'add a new negative voting to question' do
      expect(question.votes).to include(question.vote_up(user))
    end

    it 'check assosiation new negative voting with user' do
      expect(user.votes).to include(question.vote_down(user))
    end

    it 'changes vote score of question by -1' do
      vote = question.vote_down(user)
      expect(question.vote_score).to eq -1
    end
  end

  describe '#voted?' do
    it 'user can vote' do
      question.vote_down(user)
      expect(question).to be_voted(user)
    end

    it 'user cant vote' do
      expect(question).not_to be_voted(user)
    end
  end

  describe '#vote_reset' do
    it 'Reset votes' do
      question.vote_up(user)
      question.vote_reset(user)
      expect(question.vote_score).to eq 0
    end
  end
end

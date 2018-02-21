require 'rails_helper'

RSpec.describe Question, type: :model do
  it { should have_many(:answers).dependent(:destroy) }
  it { should have_many :attachments}
  it { should validate_presence_of :title }
  it { should validate_presence_of :body }
  it { should belong_to(:user) }
  it { should have_many(:votes)}
  it { should have_many(:comments)}
  it { should have_many(:subscriptions)}
  it { should have_many(:subscribers)}

  it {should accept_nested_attributes_for :attachments}

  let(:question) { create(:question, user: user) }
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  describe '#subscribed?' do
    it 'user subscribed to question or not?' do
      expect(question).to be_subscribed(user)
    end
  end

  describe '#add_subscribe' do
    it 'create a new subscribe for question' do
      expect(question.subscriptions).to include(question.subscribe(other_user))
    end
  end

  describe '#del_subscribe' do
    it 'del subscribe for question' do
      expect(question.subscriptions).to_not include(question.unsubscribe(user))
    end
  end

  let!(:object_name) { :answer }
  it_behaves_like "model_voted"
end

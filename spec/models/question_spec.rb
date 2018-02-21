require 'rails_helper'

RSpec.describe Question, type: :model do
  it { should have_many(:answers).dependent(:destroy) }
  it { should have_many :attachments}
  it { should validate_presence_of :title }
  it { should validate_presence_of :body }
  it { should belong_to(:user) }
  it { should have_many(:votes)}
  it { should have_many(:comments)}

  it {should accept_nested_attributes_for :attachments}

  let(:question) { create(:question, user: user) }
  let(:user) { create(:user) }

  let!(:object_name) { :answer }
  it_behaves_like "model_voted"
end

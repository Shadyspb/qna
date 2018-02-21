require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { should belong_to :question }
  it { should have_many :attachments }
  it { should validate_presence_of :body }
  it { should belong_to(:user) }
  it { should have_many(:votes)}
  it { should have_many(:comments)}

  it { should accept_nested_attributes_for :attachments }

  let!(:object_name) { :answer }
  it_behaves_like "model_voted"
end

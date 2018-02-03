require 'rails_helper'

RSpec.describe AnswersController, type: :controller do

  let(:user) { @user || create(:user) }
  let(:question) { create(:question, user: user) }
  let(:answer) { create(:answer,user: user, question: question) }
  let(:invalid_answer) {}


  describe 'POST #create' do
    sign_in_user
    context 'with valid attributes' do
      it 'saves new answer in database' do
        params = { answer: attributes_for(:answer), question_id: question }
        expect { post :create, params: params }.to change(question.answers, :count).by(1)
      end

      it 'saves new answer in the database with user' do
        params = { answer: attributes_for(:answer), question_id: question }
        expect { post :create, params: params }.to change(user.answers, :count).by(1)
      end

      it 'redirects to show view' do
        post :create, params: { question_id: question, answer: attributes_for(:answer) }
        expect(response).to redirect_to question_path(assigns(:question))
      end
    end

    context 'with no valid attributes' do
      it 'doesnt save the answer' do
        params = { answer: attributes_for(:invalid_answer), question_id: question }
        expect { post :create, params: params }.to_not change(Answer, :count)
      end
    end
  end

  describe 'DELETE #destroy' do
    context'user is author' do
      sign_in_user
      before { answer }

      it 'deletes answer' do
        expect { delete :destroy, params: {question_id: question, id: answer} }.to change(Answer, :count).by(-1)
        expect(response).to redirect_to question_path(assigns(:question))
      end
    end

    context'user is not author' do
      it 'deletes answer' do
        expect { delete :destroy, params: {question_id: question, id: answer} }.to change(Answer, :count)
      end
    end
  end
end

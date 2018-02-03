class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_question, only: [:create, :destroy]
  before_action :load_answer, only: [:destroy]

  def create
    @answer = current_user.answers.new(answer_params)
    @answer.question = @question

    if @answer.save
      flash[:notice] = 'Your Answer created successfully'
    else
      flash[:notice] = 'Answer not create'
    end
  end

  def destroy
    if current_user.author_of?(@answer)
      @answer.destroy
      flash[:notice] = 'Answer successfully deleted.'
     else
      flash[:notice] = 'Only author of the answer can delete it'
    end
    redirect_to question_path(@question)
  end

  private

  def load_question
    @question = Question.find(params[:question_id])
  end

  def load_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end
end

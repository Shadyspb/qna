class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_question, only: [:create, :destroy]
  before_action :load_answer, only: [:destroy, :update, :best_answer ]

  def create
    @answer = current_user.answers.new(answer_params)
    @answer.question = @question

    if @answer.save
      flash[:notice] = 'Your Answer created successfully'
    else
      render 'errors', notice:  'Answer not create'
    end
  end

  def update
    @answer.update(answer_params) if current_user.author_of?(@answer)
    @question = @answer.question
  end

  def best_answer
    if current_user.author_of?(@answer.question)
      @answer.mark_best
    end
    @question = @answer.question
  end

  def destroy
    if current_user.author_of?(@answer)
      @answer.destroy
     else
      flash.now[:notice] = 'Only an author of the answer can delete it'
      render 'common/messages'
    end
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

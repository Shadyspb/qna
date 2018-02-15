class AnswersController < ApplicationController
  include Voting
  include Comentabled

  before_action :authenticate_user!
  before_action :load_question, only: [:create, :destroy, :best_answer]
  before_action :load_answer, only: [:destroy, :update, :best_answer ]
  after_action :publish_answer, only: [:create]

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user
    flash[:notice] = if @answer.save
                      'Answer save successfully'
                     else
                      'Your question has wrong params'
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

  def publish_answer
    return if @answer.errors.any?
    attachments = @answer.attachments.map do |a|
      { id: a.id, url: a.file.url, name: a.file.identifier }
    end
    ActionCable.server.broadcast("answers_#{@question.id}", answer: @answer, attachments: attachments)
  end

  def load_question
    @question = @answer.question
  end

  def load_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body, attachments_attributes: [:file, :id, :_destroy])
  end
end

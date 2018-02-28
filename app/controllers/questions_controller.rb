class QuestionsController < ApplicationController
  include Voting
  include Comentabled

  before_action :authenticate_user!, except: [:index, :show, :update]
  before_action :load_question, only: [:show, :update, :destroy, :subscribe, :unsubscribe]
  after_action :publish_question, only: [:create]

  respond_to :html, :json
  respond_to :js, only: [:subscribe, :unsubscribe]

  authorize_resource

  def index
    respond_with(@questions = Question.all)
  end

  def show
    @answer = @question.answers.build
    @answer.attachments.build
    gon.question_owner = @question.user_id == (current_user && current_user.id)
  end

  def new
    @question = Question.new
    respond_with(@question.attachments.build)
  end

  def create
    respond_with(@question = current_user.questions.create(question_params))
  end

  def update
    @question.update(question_params) if current_user.author_of?(@question)
  end

  def destroy
    respond_with(@question.destroy) if current_user.author_of?(@question)
  end

  def subscribe
    respond_with(@question.subscribe(current_user), template: 'common/subscribe')
  end

  def unsubscribe
    respond_with(@question.unsubscribe(current_user), template: 'common/subscribe')
  end

  private

  def publish_question
    return if @question.errors.any?
    ActionCable.server.broadcast(
      'questions',
      ApplicationController.render(
        partial: 'common/list',
        locals: {question: @question}
        )
      )
  end

  def load_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body, attachments_attributes: [:file, :id, :_destroy])
  end
end

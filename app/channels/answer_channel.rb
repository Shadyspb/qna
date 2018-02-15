class AnswerChannel < ApplicationCable::Channel
  def follow
    stream_from "answers_#{params[:id]}"
  end
end

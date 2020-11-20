class AnswersController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @question = Question.find params[:question_id]
    @answer = Answer.new params.require(:answer).permit(:body)
    @answer.question = @question
    @answer.user= current_user
    if @answer.save
      redirect_to question_path(@question)
    else
      render 'questions/show'
    end
  end

  def destroy
    @answer = Answer.find params[:id]
    if can?(:crud,@answer)
    @answer.destroy
    redirect_to question_path(@answer.question)
    else
      #  head will send an empty HTTP response  with a particular response code, in this case 
      # unauthorized 401
      # # http://billpatrianakos.me/blog/2013/10/13/list-of-rails-status-code-symbols/

      head :unauthorized
    end
  end
end

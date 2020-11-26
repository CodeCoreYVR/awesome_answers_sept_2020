class LikesController < ApplicationController
  def create
    # 1) Question -> params[:question_id]
    # 2) User -> current_user (Session/Cookies)
    question = Question.find params[:question_id]
    like = Like.new(question: question, user: current_user)

    if like.save
      flash[:success] = "Question Liked!"
    else
      flash[:danger] = like.errors.full_messages.join(", ")
    end
    redirect_to question_path(question)
  end
end

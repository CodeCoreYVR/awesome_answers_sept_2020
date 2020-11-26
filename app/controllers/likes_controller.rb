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

  def destroy
    # like = Like.find_by(question: params[:question_id], user: current_user) => no longer works after setting shallow: true because there's no longer a question_id parameter
    like = current_user.likes.find params[:id]
    if like.destroy
      flash[:success] = "Question Un-Liked" 
    else
      flash[:warning] = "It's rude to unlike something you've already liked"
    end

    redirect_to question_path(like.question)
  end
end

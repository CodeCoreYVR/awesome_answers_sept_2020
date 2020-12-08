class Api::V1::QuestionsController < Api::ApplicationController

  def index
    questions = Question.order(created_at: :desc)
    # provide the each_serializer option to the render method to specify which serializer to use
    render(json: questions, each_serializer: QuestionCollectionSerializer)
  end

  def show
    question = Question.find(params[:id])
    render(json: question)
  end

  def create
    question = Question.new(params.require(:question).permit(:title, :body, :tag_names))
    question.user = current_user
    if question.save
      render json: { id: question.id }
    else
      render(
        json: { errors: question.errors },
        status: 422 # unprocessable entity HTTP Code
      )
    end
  end
end
class Api::V1::QuestionsController < Api::ApplicationController
  before_action :find_question, only: [:show,:update, :destroy]

  def index
    questions = Question.order(created_at: :desc)
    # provide the each_serializer option to the render method to specify which serializer to use
    render(json: questions, each_serializer: QuestionCollectionSerializer)
  end

  def show
    @question = Question.find(params[:id])
    render(json: @question)
  end

  def create
    question = Question.new question_params
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
  def update
    if @question.update question_params
      render json: {id: @question.id}
    else
      render(
      json:{ errors: @question.errors},
      status: 422)

    end
  end

  def destroy
    @question.destroy
    render(json: {errors: @question.errors}, status:200)
  end
  private
  def find_question
    @question||=Question.find params[:id]
  end
  def question_params
    params.require(:question).permit(:title, :body, :tag_names)
  end
end

class Api::V1::QuestionsController < Api::ApplicationController
  before_action :find_question, only: [:show, :update]

  def index
    questions = Question.order(created_at: :desc)
    render(
      json: questions
    )
  end

  def show
    render(
      json: @question
    )
  end

  def create
    question = Question.new question_params

    if question.save 
      render json: { id: question.id }
    else
      render(
        json: { errors: question.errors.messages },
        status: 422 # Unprocessable Entity
      )
    end
  end

  def update
    if @question.update question_params
      render json: { id: @question.id }
    else
      render(
        json: { errors: @question.errors.messages },
        status: 422 # Unprocessable Entity
      )
    end
  end

  private

  def find_question
    @question ||= Question.find params[:id]
  end

  def question_params
    params.require(:question).permit(:title, :body)
  end
end

class Api::V1::QuestionsController < ApplicationController
  def index
    questions = Question.order(created_at: :desc)
    # provide the each_serializer option to the render method to specify which serializer to use
    render(json: questions, each_serializer: QuestionCollectionSerializer)
  end

  def show
    question = Question.find(params[:id])
    render(json: question)
  end
end

class QuestionsController < ApplicationController
  # returns every question from the database
  def index
    @questions = Question.all # Model.all is a method built into active record used to return all records of that model
  end

  def new
    # because Rails form helper methods need an instance of a model to work we create a new instance
    @question = Question.new
  end

  def create
    # params.require(:question): We must have a question object on the params of the request
    # .permit(:title, :body): For security reasons we only permit the title and body key/value pairs of the question
    @question = Question.new params.require(:question).permit(:title, :body)
    if @question.save
      # flash is a hash that is accessible within controllers. It's also available within the views
      flash[:notice] = "Question created successfully"
      redirect_to question_path(@question)
    else
      # will render the view: views/questions/new.html.erb
      render :new
    end
  end

  def show
    @question = Question.find params[:id]
  end

  def edit
    @question = Question.find params[:id]
  end

  def update
    @question = Question.find params[:id]
    if @question.update params.require(:question).permit(:title, :body)
      redirect_to question_path(@question)
    else
      render :edit
    end
  end

  def delete
    @question = Question.find params[:id]
    @question.destroy
    redirect_to questions_index_path
  end
end

class QuestionsController < ApplicationController
  # see more about controller hooks/callbacks here https://api.rubyonrails.org/classes/AbstractController/Callbacks/ClassMethods.html
  before_action :find_question, only: [:show, :edit, :update, :destroy]
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
    @question = Question.new question_params
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
  end

  def edit
  end

  def update
    if @question.update question_params
      redirect_to question_path(@question)
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    redirect_to questions_path
  end

  def newest
    @question = Question.all.order(created_at: 'desc')[0]
    render :show
  end

  private

  def question_params
    params.require(:question).permit(:title, :body)
  end

  def find_question
    @question = Question.find params[:id]
  end

end


# Rails RESTful Routes URL Helper Method Convention
# If we're using resources :questions in /config/routes.rb
# Rails will create URL Helper methods that look like the following:

# questions_path = '/questions'
# new_question_path = '/questions/new'
# edit_question_path = '/questions/:id/edit'
# question_path = '/questions/:id'
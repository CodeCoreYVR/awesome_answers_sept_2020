class QuestionsController < ApplicationController
  before_action :authenticate_user!, except:[:index, :show]
  before_action :authorize_user!, only:[:edit,:update,:destroy]
  # Methods ending in ! perform some permanent or potentially dangerous change
  
  # see more about controller hooks/callbacks here https://api.rubyonrails.org/classes/AbstractController/Callbacks/ClassMethods.html
  before_action :find_question, only: [:show, :edit, :update, :destroy]
  # returns every question from the database
  def index
    # byebug
    if params[:tag]
      @tag=Tag.find_or_initialize_by(name: params[:tag])
      @questions=@tag.questions.all.order('updated_at DESC')
      
    else
      @questions = Question.all # Model.all is a method built into active record used to return all records of that model
      # respond_to is a method that allows us to specify a response for a given type of request
      # we can use the curl shell command to send requests
      # curl http://localhost:3000/questions - will send a GET to the url
      # curl -H "Accept: application/json" http://localhost:3000/questions
      # will send a GET request with some information on the header that tells the server this request wants JSON data.
      respond_to do |format|
        format.html { render } # if the request is asking for html respond with our html template
        format.json { render json: @questions } # if the request is asking for JSON respond with json that looks like @questions
      end
    end
    
  end

  def new
    # because Rails form helper methods need an instance of a model to work we create a new instance
    @question = Question.new
  end

  def create
    # params.require(:question): We must have a question object on the params of the request
    # .permit(:title, :body): For security reasons we only permit the title and body key/value pairs of the question
    @question = Question.new question_params
    @question.user = current_user
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
    @answer = Answer.new # is to make sure form_with works...
    @answers = @question.answers
    @like = @question.likes.find_by(user: current_user)
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

  def liked
    @questions = current_user.liked_questions.order(created_at: :desc)
  end

  private

  def question_params
    params.require(:question).permit(:title, :body, :tag_names)
  end

  def find_question
    @question = Question.find params[:id]
  end
  def authorize_user!
    redirect_to root_path, alert:"Not Authorized" unless can?(:crud,@question)#Fix:  👈🏻Change from Question to @question
  end

end


# Rails RESTful Routes URL Helper Method Convention
# If we're using resources :questions in /config/routes.rb
# Rails will create URL Helper methods that look like the following:

# questions_path = '/questions'
# new_question_path = '/questions/new'
# edit_question_path = '/questions/:id/edit'
# question_path = '/questions/:id'
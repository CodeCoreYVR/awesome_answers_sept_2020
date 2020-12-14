Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # when someone visits GET localhost:3000/ it will be handled by "WelcomeController" index Method
  get('/', { to: 'welcome#index', as: 'root' })
  get('/goodbye', { to: 'welcome#goodbye' })

  get('/contacts/new', {to: 'contacts#new'})
  post('/contacts', {to: 'contacts#create'})

  # https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods documentation for all the verbs

  # RESTful Routes for Questions feature
  # index: GET "/<resource>s" - return all records of that resource
  # GET "/questions" - return all questions in the database
  # new: GET "/<resource>/new" - return a view with a form to create a resource
  # GET "/questions/new" - A form to create a new question
  # create: POST "/<resource>" - handle the submission of the "new form"
  # POST "/questions" - insert a question into the database
  # show: GET "/<resource>/:id" - return one record of that resource
  # GET "/questions/1" - return a show page for question with id of 1
  # edit: GET "/<resource>/:id/edit" - return a view with a form to update a existing resource
  # GET "/questions/1/edit" - returns a form to edit the question with id of 1
  # update: PATCH "/<resource>/:id" - handle the submission of the "edit form"
  # PATCH "/questions/1" - update the question with the id of 1
  # delete: Delete "/<resource>/:id" - delete a record from the database
  # DELETE "/questions/1" - delete the question with id of 1

  # index
  # get('/questions', { to: 'questions#index' })
  # # new
  # get('/questions/new', { to: 'questions#new', as: :new_question })
  # # create
  # post('/questions', { to: 'questions#create' })
  # # show
  # get('/questions/:id', { to: 'questions#show', as: :question })
  # # edit
  # get('/questions/:id/edit', { to: 'questions#edit', as: :edit_question })
  # # update
  # patch('/questions/:id', { to: 'questions#update' })
  # # delete
  # delete('/questions/:id', { to: 'questions#destroy' })

  get('/questions/newest', { to: 'questions#newest' })
  #builds all of the above RESTful routes to Rails Convention
  resources :questions do
    # index => GET '/questions/:question_id/answers'
    # new =>  GET '/questions/:question_id/answers/new'
    # create => POST '/questions/:question_id/answers'
    # show => GET '/questions/:question_id/answers/:id'
    # edit => GET '/questions/:question_id/answers/:id/edit'
    # update => PATCH '/questions/:question_id/answers/:id'
    # delete => DELETE '/questions/:question_id/answers/:id'
    resources :answers, only: [:create, :destroy]
    resources :likes, shallow: true, only: [:create, :destroy]
    # /questions/:question_id/likes
    # /questions/likes/:id => with shallow: true
    # /questions/:question_id/likes/:id => with shallow: false (default)
    get :liked, on: :collection # => GET /questions/liked { to: 'questions#liked' }
  end

  resources :users, only:[:new, :create]
  resource :session, only:[:new, :create, :destroy]

  # 👆🏻 resource is singular instead of resources
# Unlike resources, resource will create routes that do CRUD operation on Only single thing. There will be no index routes not route will ne having :id (patch, put) wildcard.
# Note: When using a singular resource the controller name will still be plural

resources :job_posts, only: [:new, :create, :show, :index, :destroy, :edit, :update]

match "/delayed_job" => DelayedJobWeb, :anchor => false, :via => [:get, :post]

  # /api/v1/questions
  # /api/v1/quetions/:id
  namespace :api, default: { format: :json } do
    namespace :v1 do
      resources :questions, only: [:index, :show, :create, :update, :destroy]
      resources :sessions, only: [:create]
      resources :users, only: [:create]
    end
  end
end

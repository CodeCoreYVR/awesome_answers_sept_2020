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
  get('/questions', { to: 'questions#index', as: :questions_index })
  # new
  get('/questions/new', { to: 'questions#new', as: :new_question })
  # create
  post('/questions', { to: 'questions#create', as: :questions })
  # show
  get('/questions/:id', { to: 'questions#show', as: :question })
  # edit
  get('/questions/:id/edit', { to: 'questions#edit', as: :edit_question })
  # update
  patch('/questions/:id', { to: 'questions#update' })
  # delete
  delete('/questions/:id', { to: 'questions#delete' })

  # resources :questions
end

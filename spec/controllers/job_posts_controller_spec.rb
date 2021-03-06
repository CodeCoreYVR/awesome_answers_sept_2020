require "rails_helper"

# Rspec API Documentation # https://rspec.info/documentation/4.0/rspec-rails/

RSpec.describe JobPostsController, type: :controller do
  describe "#new" do
    context "with user signed in" do
      before do
        session[:user_id] = FactoryBot.create(:user).id
      end
      it "renders the new template" do
        # GIVEN
  
        # WHEN
        get(:new)
        # The Rspec-Rails gem gives us this method to "mock" a request to the new action. More info at https://rspec.info/documentation/4.0/rspec-rails/RSpec/Rails/Matchers/RoutingMatchers/RouteHelpers.html#get-instance_method
  
        # THEN
        expect(response).to(render_template(:new))
        # response is an object that represents the HTTP-Response
        # Rspec makes this object available within the specs
        # We verify that the response will render out the template called "new" using the matcher `rendered_template`
      end
  
      it "sets an instance variable with a new job post" do
        # GIVEN
  
        # WHEN
        get(:new)
  
        # THEN
        # assign(:job_post) available from the `rails-controller-testing` gem allows you to grab an instance varaible
        expect(assigns(:job_post)).to(be_a_new(JobPost))
        # we check that the instance variable @job_post is a new instance of the class JobPost (Model)
      end
    end

    context "without signed in user" do
      it "should redirect to the sign in page" do
        get(:new)
        expect(response).to redirect_to(new_session_path)
      end
    end
  end

  describe "#create" do
    def valid_request
      post(:create, params: { job_post: FactoryBot.attributes_for(:job_post) })
    end
    context "with user signed in" do
      before do
        # mimics a user signed in
        session[:user_id] = FactoryBot.create(:user).id
      end

      context "with valid parameters" do
  
        it "creates a job post in the database" do
          # GIVEN
          count_before = JobPost.count # the number of all the records in the JobPost table
          # WHEN
          valid_request
          # mocking a post request to the create method. The params of the request will look similar to: {
          #   job_post: {
          #     title: 'senior dev',
          #     description: 'lots of pay',
          #     location: 'remote',
          #     min_salary: 500_000,
          #     max_salary: 1_000_000
          #   }
          # }
  
          # THEN
          count_after = JobPost.count
          expect(count_after).to(eq(count_before + 1))
          # eq is an assertion provided by Rspec that checks the value to the right of the .to is equal to the paramater passed in to the method.
        end
  
        it "redirects us to the show page for that post" do
          # GIVEN
          # WHEN
          valid_request
          # THEN
          job_post = JobPost.last
          expect(response).to(redirect_to(job_post_url(job_post.id)))
        end
      end
  
      context "with invalid paramters" do
        def invalid_request
          post(:create, params: { job_post: FactoryBot.attributes_for(:job_post, title: nil) })
          # factorybot will create a invalid hash that looks like:
          #   job_post: {
          #     title: nil,
          #     description: 'lots of pay',
          #     location: 'remote',
          #     min_salary: 500_000,
          #     max_salary: 1_000_000
          #   }
          # }
        end
  
        it "does not save a record in the database" do
          count_before = JobPost.count
          invalid_request
          count_after = JobPost.count
          expect(count_after).to eq(count_before)
        end
  
        it "renders the new template" do
          invalid_request
          expect(response).to render_template(:new)
        end
  
      end
    end

    context "with user not signed in" do

      it "should redirect to the sign in page" do
        valid_request
        expect(response).to redirect_to(new_session_path)
      end

    end

    
  end

  describe "#show" do
    it "render show template" do
      #GIVEN
      job_post = FactoryBot.create(:job_post)
      #WHEN
      get(:show, params: { id: job_post.id })
      #THEN
      expect(response).to render_template(:show)
    end

    it "sets an instance variable @job_post for the shown object" do
      job_post = FactoryBot.create(:job_post)
      get(:show, params: { id: job_post.id })
      expect(assigns(:job_post)).to eq(job_post)
    end
  end

  describe "#index" do
    it "render the index template" do
      get(:index)
      expect(response).to render_template(:index)
    end

    it "assign an instance variable @job_posts which contains all the created job posts" do
      job_post_1 = FactoryBot.create(:job_post)
      job_post_2 = FactoryBot.create(:job_post)
      job_post_3 = FactoryBot.create(:job_post)

      get(:index)

      expect(assigns(:job_posts)).to eq([job_post_3, job_post_2, job_post_1])
    end
  end

  describe "#destroy" do
    
    context "with signed in user" do
      
      context "as owner" do
        before do # will run all of this code before every single test within the this describe block
          current_user = FactoryBot.create(:user)
          session[:user_id] = current_user.id # sign in user
          #GIVEN
          @job_post = FactoryBot.create(:job_post, user: current_user)
          #WHEN
          delete(:destroy, params: { id: @job_post.id })
        end

        it "should remove a job post from the database" do
          #THEN
          expect(JobPost.find_by(id: @job_post.id)).to be(nil)
        end
    
        it "redirect to the job post index" do
          #THEN
          expect(response).to redirect_to(job_posts_path)
        end
    
        it "set a flash message" do
          expect(flash[:danger]).to be # assert that the danger property of the flash object exists
        end
      end

      context "as non owner" do
        before do
          current_user = FactoryBot.create(:user)
          session[:user_id] = current_user
          @job_post = FactoryBot.create(:job_post)
          # current logged in user IS NOT the user that owns @job_post
        end

        it "does not remove the job post" do
          delete(:destroy, params: { id: @job_post.id })
          expect(JobPost.find(@job_post.id)).to eq(@job_post)
        end
      end

    end

  end

  describe "#edit" do
    context "with signed in user" do

      context "as owner" do
        before do
          current_user = FactoryBot.create(:user)
          session[:user_id] = current_user.id # session[:user_id] is the same id as @job_post.user.id
          @job_post = FactoryBot.create(:job_post, user: current_user)
        end
        it "render the edit template" do
          get :edit, params: { id: @job_post.id }
          expect(response).to render_template :edit
        end 
      end

      context "as non owner" do
        before do
          current_user = FactoryBot.create(:user) 
          session[:user_id] = current_user.id # session[:user_id] is NOT the same as @job_post.user.id
          @job_post = FactoryBot.create(:job_post)
        end
        it "should redirect to show page" do
          get :edit, params: { id: @job_post.id }
          expect(response).to redirect_to job_post_path(@job_post)
        end
      end

    end
  end

  describe "#update" do
    before do
      @job_post = FactoryBot.create(:job_post)
    end

    context "with signed in user" do
      before do
        session[:user_id] = FactoryBot.create(:user)
      end

      context "with valid parameters" do
  
        it "update the job post record with new attributes" do
          new_title = "#{@job_post.title} Plus some changes!!!"
          patch :update, params: { id: @job_post.id, job_post: { title: new_title}}
          expect(@job_post.reload.title).to eq new_title
        end
  
        it "redirects to the show page" do
          new_title = "#{@job_post.title} Plus some changes!!!"
          patch :update, params: { id: @job_post.id, job_post: { title: new_title}}
          expect(response).to redirect_to(@job_post)
        end
      end
  
      context "with invalid parameters" do
  
        it "should not update the job post record" do
          patch :update, params: { id: @job_post.id, job_post: { title: nil }}
          job_post_after_update = JobPost.find(@job_post.id)
          expect(job_post_after_update.title).to eq @job_post.title
        end
  
      end
    end

  end
end
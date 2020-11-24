require "rails_helper"

# Rspec API Documentation # https://rspec.info/documentation/4.0/rspec-rails/

RSpec.describe JobPostsController, type: :controller do
  describe "#new" do
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

  describe "#create" do
    def valid_request
      post(:create, params: { job_post: FactoryBot.attributes_for(:job_post) })
    end

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
end
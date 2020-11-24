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
end
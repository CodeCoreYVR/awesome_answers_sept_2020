class ContactsController < ApplicationController
  # the new action is used to render a form that creates a new resource
  def new

  end

  def create
    # params is an hash that contains information from the form that was submitted
    # we can create instance variables. These variables are available inside of views
    @name = params['name']
    @email = params['email']
    @message = params['message']
  end
end

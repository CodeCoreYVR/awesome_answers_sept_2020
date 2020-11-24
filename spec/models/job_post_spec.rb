# rspec -f d 👈🏻 for running this file
require 'rails_helper'
# matchers docs https://relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
RSpec.describe JobPost, type: :model do # rspec has alread injected JobPost model into this file
  describe "validates" do

    describe "title" do
    it "requires a title" do
      # Given
      job_post=FactoryBot.build(:job_post, title: nil)

      # When
      job_post.valid?

      # Then
      expect(job_post.errors.messages).to(have_key(:title))
      # expect is passed a value we are asserting
      # we can chain .to()
      # .to() accepts an assertion / expectation clause

    end
    it "title is unique" do
      # given 
      persisted_job_post = FactoryBot.create(:job_post)

      #when
      job_post=FactoryBot.build(:job_post, title: persisted_job_post.title)
      job_post.valid?

      # Then
      expect(job_post.errors.messages).to(have_key(:title))

    end
  end 
  describe "description" do
    it "requires a description" do
      # Given
      job_post=FactoryBot.build(:job_post, description: nil)
      # When
      job_post.valid?

      # Then
      expect(job_post.errors.messages).to(have_key(:description))
    end
    it 'must be larger than 100 characters'do
    # Given
    job_post=FactoryBot.build(:job_post, description: 'less than 100')

    # When
    job_post.valid?

    # Then
# byebug
    expect(job_post.errors.messages).to(have_key(:description))
  end
  end
  describe "location" do
    it 'is required' do
      # Given
      job_post= FactoryBot.build(:job_post, location: nil)

      # When
      job_post.valid?

      # Then
      expect(job_post.errors.messages).to(have_key(:location))
    end
  end
  describe "min_salary" do
    it "salary_min must be a number greater than 30_000" do
      # Given
      job_post=FactoryBot.build(:job_post, min_salary: 25_000)

      # When
      job_post.valid?

      # Then
              # the error object on models have a method .details() that returns a hash, with keys equal to columns that have errors. The value of those keys are an array of error messages each with a error key whose value is a validation symbol

      expect(job_post.errors.details[:min_salary][0][:error]).to(be(:greater_than_or_equal_to))


    end
  end
  end

  


end

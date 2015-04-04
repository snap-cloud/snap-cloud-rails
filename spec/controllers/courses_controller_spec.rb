require 'spec_helper'

describe CoursesController do
  before(:each) do 
    @course = Course.create(title: "course", description: "desc")
  end

  describe "GET 'new'" do
    it "returns http success" do
      get 'courses/new'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      get "courses/#{@course.id}/"
      response.should be_success
    end
  end

  describe "GET 'edit'" do
    it "returns http success" do
      get "/courses/#{@course.id}/edit"
      response.should be_success
    end
  end


end

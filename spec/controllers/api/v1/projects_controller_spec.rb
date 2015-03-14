require 'spec_helper'
require 'api/v1/projects_controller'

describe Api::V1::ProjectsController do

  before(:each) { request.headers['Accept'] = "application/json" }

  describe "GET #show" do
    before(:each) do
      @project = FactoryGirl.create :project
      get :show, id: @project.id, format: :json
    end

    it "returns the information about a reporter on a hash" do
      project_response = JSON.parse(response.body, symbolize_names: true)
      expect(project_response[:email]).to eql @project.email
    end

    it { should respond_with 200 }
  end

  describe "POST #create" do

    context "when is successfully created" do
      before(:each) do
        @project_attributes = FactoryGirl.attributes_for :project
        post :create, { project: @project_attributes }, format: :json
      end

      it "renders the json representation for the project record just created" do
        project_response = JSON.parse(response.body, symbolize_names: true)
        expect(project_response[:email]).to eql @project_attributes[:email]
      end

      it { should respond_with 201 }
    end

    context "when is not created" do
      before(:each) do
        #notice I'm not including the email
        @invalid_project_attributes = { password: "12345678",
                                     password_confirmation: "12345678" }
        post :create, { project: @invalid_project_attributes }, format: :json
      end

      it "renders an errors json" do
        project_response = JSON.parse(response.body, symbolize_names: true)
        expect(project_response).to have_key(:errors)
      end

      it "renders the json errors on whye the project could not be created" do
        project_response = JSON.parse(response.body, symbolize_names: true)
        expect(project_response[:errors][:email]).to include "can't be blank"
      end

      it { should respond_with 422 }
    end
  end

  describe "DELETE #destroy" do
    before(:each) do
      @project = FactoryGirl.create :project
      delete :destroy, { id: @project.id }, format: :json
    end
    
    it { should respond_with 204 }
    
  end

  describe "PUT/PATCH #update" do

    context "when is successfully updated" do
      before(:each) do
        @project = FactoryGirl.create :project
        patch :update, { id: @project.id,
                         project: { email: "newmail@example.com" } }, format: :json
      end

      it "renders the json representation for the updated project" do
        project_response = JSON.parse(response.body, symbolize_names: true)
        expect(project_response[:email]).to eql "newmail@example.com"
      end

      it { should respond_with 200 }
    end

    context "when is not created" do
      before(:each) do
        @project = FactoryGirl.create :project
        patch :update, { id: @project.id,
                         project: { email: "bademail.com" } }, format: :json
      end

      it "renders an errors json" do
        project_response = JSON.parse(response.body, symbolize_names: true)
        expect(project_response).to have_key(:errors)
      end

      it "renders the json errors on whye the project could not be created" do
        project_response = JSON.parse(response.body, symbolize_names: true)
        expect(project_response[:errors][:email]).to include "is invalid"
      end

      it { should respond_with 422 }
    end
  end

end

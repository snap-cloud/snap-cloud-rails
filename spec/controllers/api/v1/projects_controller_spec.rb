require 'spec_helper'
require 'api/v1/projects_controller'
require 'byebug'

describe Api::V1::ProjectsController do

  before(:each) { request.headers['Accept'] = "application/json" }

  describe "GET #show" do
    before(:each) do
      @project = FactoryGirl.create :project

      fakeuser = double('user')
      allow(request.env['warden']).to receive(:authenticate!).and_return(fakeuser)
      allow(controller).to receive(:current_user).and_return(fakeuser)

      get :show, id: @project.id, format: :json
    end

    it { should respond_with 200 }
  end


  describe "PUT #update" do
    before(:each) do
      Project.stub(:valid?).and_return(true)
      Project.any_instance.stub(:valid?).and_return(true)
      User.stub(:valid?).and_return(true)
      User.any_instance.stub(:valid?).and_return(true)

      fakeuser = double('user')
      allow(request.env['warden']).to receive(:authenticate!).and_return(fakeuser)
      allow(controller).to receive(:current_user).and_return(fakeuser)
    end
    
    it "should update the project when I own it and it exists" do
      user = User.create(email: "steven@berk.edu")
      proj = Project.create(title: "Test proj", owner:user.id)
      Project.any_instance.should_receive(:update_attributes)
      Api::V1::ProjectsController.any_instance.stub(:getCurrentUser).and_return(user)
      put :update, { project_params: proj.attributes, id:proj.id }, format: :json
      expect(response.status).to eq(204)
    end

    it "should reject the request when I am not logged in" do
      proj = Project.create(title: "Test proj")
      Api::V1::ProjectsController.any_instance.stub(:getCurrentUser).and_return(nil)
      put :update, { project_params: proj.attributes, id:proj.id}, format: :json
      expect(response.status).to eq(401)
    end

    it "should reject the request when I don't own the project" do
      user = User.create(email: "steven@berk.edu")
      not_users_id = user.id+1
      proj = Project.create(title: "Test proj", owner:(not_users_id))
      Api::V1::ProjectsController.any_instance.stub(:getCurrentUser).and_return(user)
      put :update, { project_params: proj.attributes, id:proj.id }, format: :json
      expect(response.status).to eq(401)
    end    

    it "should reject the request when the project doesn't exist" do
      user = User.create(email: "steven@berk.edu")
      proj = Project.create(title: "Test proj", owner:user.id)
      Api::V1::ProjectsController.any_instance.stub(:getCurrentUser).and_return(user)
      put :update, { project_params: proj.attributes, id:(proj.id+1) }, format: :json
      expect(response.status).to eq(404)
    end
  end


  describe "POST #create" do
    before(:each) do
      Project.stub(:valid?).and_return(true)
      Project.any_instance.stub(:valid?).and_return(true)

      fakeuser = double('user')
      allow(request.env['warden']).to receive(:authenticate!).and_return(fakeuser)
      allow(controller).to receive(:current_user).and_return(fakeuser)
    end

    it "should create a project for the user if user is present" do
      user1 = User.create(email: "linda@berk.edu")
      Api::V1::ProjectsController.any_instance.stub(:getCurrentUser).and_return(user1)

      post :create, {project_params: {title: "test proj for user 1", owner:user1.id}}
      expect(response.status).to eq(200) #:ok
    end

 

 
  end

  describe "DELETE #destroy" do
    before(:each) do
      Project.stub(:valid?).and_return(true)
      Project.any_instance.stub(:valid?).and_return(true)
      User.stub(:valid?).and_return(true)
      User.any_instance.stub(:valid?).and_return(true)

      fakeuser = double('user')
      allow(request.env['warden']).to receive(:authenticate!).and_return(fakeuser)
      allow(controller).to receive(:current_user).and_return(fakeuser)
    end

    it "should delete the project if user is an owner" do
      user1 = User.create(email: "linda@berk.edu")
      user2 = User.create(email: "ellen@berk.edu")
      Api::V1::ProjectsController.any_instance.stub(:getCurrentUser).and_return(user1)
      user1_proj = Project.create(title: "user1 proj", owner:user1.id)

      delete :destroy, {id: user1_proj.id}
      #project_response = JSON.parse(response.body, symbolize_names: true)
      ## response is populated with last response; last line is unnecessary for now
      expect(response.status).to eq(200) #:ok
    end
    
    it "should reject the request if user is not an owner" do 
      user1 = User.create(email: "linda@berk.edu")
      user2 = User.create(email: "ellen@berk.edu")
      Api::V1::ProjectsController.any_instance.stub(:getCurrentUser).and_return(user2)
      user1_proj = Project.create(title: "user1 proj", owner:user1.id)

      delete :destroy, {id: user1_proj.id} 
      #project_response = JSON.parse(response.body, symbolize_names: true)
      ## response is populated with last response; last line is unnecessary for now
      expect(response.status).to eq(401) #:unauthorized
    end 
  end

  describe "GET #index" do
    before(:each) do
      Project.stub(:valid?).and_return(true)
      Project.any_instance.stub(:valid?).and_return(true)
      User.stub(:valid?).and_return(true)
      User.any_instance.stub(:valid?).and_return(true)

      fakeuser = double('user')
      allow(request.env['warden']).to receive(:authenticate!).and_return(fakeuser)
      allow(controller).to receive(:current_user).and_return(fakeuser)
    end

    it "Should show all projects belonging to user if logged in" do
      user = User.create(email: "jwang@berk.edu")
      not_users_id = user.id+1
      Api::V1::ProjectsController.any_instance.stub(:getCurrentUser).and_return(user)
      proj1 = Project.create(title: "user public", owner:user.id, is_public: 1)
      proj2 = Project.create(title: "user private", owner:user.id, is_public: 0)
      proj3 = Project.create(title: "nonuser public", owner:not_users_id, is_public: 1)
      proj4 = Project.create(title: "nonuser private", owner:not_users_id, is_public: 0)
      get :index, {user_id: user.id}, format: :json
      project_response = JSON.parse(response.body, symbolize_names: true)
      expect(project_response.length).to eq(2)
      expect(project_response[0][:title]).to eq("user public")
      expect(project_response[1][:title]).to eq("user private")
    end

    it "Should show only public projects if user not logged in" do
      user = User.create(email: "jwang@berk.edu")
      not_users_id = user.id+1
      Api::V1::ProjectsController.any_instance.stub(:getCurrentUser).and_return(nil)
      proj1 = Project.create(title: "user public", owner:user.id, is_public: 1)
      proj2 = Project.create(title: "user private", owner:user.id, is_public: 0)
      proj3 = Project.create(title: "nonuser public", owner:not_users_id, is_public: 1)
      proj4 = Project.create(title: "nonuser private", owner:not_users_id, is_public: 0)
      get :index, {user_id: user.id}, format: :json
      project_response = JSON.parse(response.body, symbolize_names: true)
      expect(project_response.length).to eq(1)
      expect(project_response[0][:title]).to eq("user public")
    end
  end

  # describe "PUT/PATCH #update" do

  #   context "when is successfully updated" do
  #     before(:each) do
  #       @project = FactoryGirl.create :project
  #       patch :update, { id: @project.id,
  #                        project: { title: "new title" } }, format: :json
  #     end

  #     it "renders the json representation for the updated project" do
  #       project_response = JSON.parse(response.body, symbolize_names: true)
  #       expect(project_response[:title]).to eql "new title"
  #     end

  #     it { should respond_with 200 }
  #   end

  #   context "when is not created" do
  #     before(:each) do
  #       @project = FactoryGirl.create :project
  #       patch :update, { id: @project.id,
  #                        project: { title: "bad title" } }, format: :json
  #     end

  #     it "renders an errors json" do
  #       project_response = JSON.parse(response.body, symbolize_names: true)
  #       expect(project_response).to have_key(:errors)
  #     end

  #     it "renders the json errors on why the project could not be created" do
  #       project_response = JSON.parse(response.body, symbolize_names: true)
  #       expect(project_response[:errors][:title]).to include "is invalid"
  #     end

  #     it { should respond_with 422 }
  #   end
  # end

end

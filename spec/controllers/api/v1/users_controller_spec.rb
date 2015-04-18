require 'spec_helper'
require 'sessions_controller'
require 'registrations_controller'
require 'api/v1/users_controller'

describe Api::V1::UsersController do

  before(:each) { request.headers['Accept'] = "application/json" }

  describe "GET #show" do
    before(:each) do
      #Added by steve for alec
      fakeuser = double('user')
      allow(request.env['warden']).to receive(:authenticate!).and_return(fakeuser)
      allow(controller).to receive(:current_user).and_return(fakeuser)



      @user = FactoryGirl.create :user
      get :show, id: @user.id, format: :json

    end

    it "returns the information about a reporter on a hash" do
      user_response = JSON.parse(response.body, symbolize_names: true)
      expect(user_response[:email]).to eql @user.email
    end

    it { should respond_with 200 }
  end

  describe "POST #create" do

    context "when is successfully created" do
      before(:each) do
        @user_attrs = FactoryGirl.attributes_for :user

        # Added by steve for alec
        fakeuser = double('user')
        allow(request.env['warden']).to receive(:authenticate!).and_return(fakeuser)
        allow(controller).to receive(:current_user).and_return(fakeuser)

        post :create, { user: @user_attrs }, format: :json
      end

      it "renders the json representation for the user record just created" do
        user_response = JSON.parse(response.body, symbolize_names: true)
        expect(user_response[:email]).to eql @user_attrs[:email]
      end

      it { should respond_with 201 }
    end

    context "when is not created" do
      before(:each) do
        #notice I'm not including the email
        @invalid_user_attributes = { password: "12345678",
                                     password_confirmation: "12345678" }

        #Added by steve for alec
        fakeuser = double('user')
        allow(request.env['warden']).to receive(:authenticate!).and_return(fakeuser)
        allow(controller).to receive(:current_user).and_return(fakeuser)


        post :create, { user: @invalid_user_attributes }, format: :json
      end

      it "renders an errors json" do
        user_response = JSON.parse(response.body, symbolize_names: true)
        expect(user_response).to have_key(:errors)
      end

      it "renders the json errors on why the user could not be created" do
        user_response = JSON.parse(response.body, symbolize_names: true)
        expect(user_response[:errors][:email]).to include "can't be blank"
      end

      it { should respond_with 422 }
    end
  end

  describe "DELETE #destroy" do
    before(:each) do
      @user = FactoryGirl.create :user

      #Added by steve for alec
      fakeuser = double('user')
      allow(request.env['warden']).to receive(:authenticate!).and_return(fakeuser)
      allow(controller).to receive(:current_user).and_return(fakeuser)

      delete :destroy, { id: @user.id }, format: :json


    end

    it { should respond_with 204 }

  end

  describe "PUT/PATCH #update" do

    context "when is successfully updated" do
      before(:each) do
        @user = FactoryGirl.create :user


        fakeuser = double('user')
        allow(request.env['warden']).to receive(:authenticate!).and_return(fakeuser)
        allow(controller).to receive(:current_user).and_return(fakeuser)

        patch :update, { id: @user.id,
                         user: { email: "newmail@example.com" } }, format: :json

      end

      it "renders the json representation for the updated user" do
        user_response = JSON.parse(response.body, symbolize_names: true)
        expect(user_response[:email]).to eql "newmail@example.com"
      end

      it { should respond_with 200 }
    end

    context "when is not created" do
      before(:each) do
        @user = FactoryGirl.create :user

        fakeuser = double('user')
        allow(request.env['warden']).to receive(:authenticate!).and_return(fakeuser)
        allow(controller).to receive(:current_user).and_return(fakeuser)


        patch :update, { id: @user.id,
                         user: { email: "bademail.com" } }, format: :json
      end

      it "renders an errors json" do
        user_response = JSON.parse(response.body, symbolize_names: true)
        expect(user_response).to have_key(:errors)
      end

      it "renders the json errors for why the user could not be created" do
        user_response = JSON.parse(response.body, symbolize_names: true)
        expect(user_response[:errors][:email]).to include "is invalid"
      end

      it { should respond_with 422 }
    end
  end

end

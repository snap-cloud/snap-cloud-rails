class PagesController < ApplicationController
  def index
  	if user_sign_in?
  		render 'dashboard' 
  	else
  		render 'index'
  	end
  end

end

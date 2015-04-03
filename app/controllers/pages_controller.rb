class PagesController < ApplicationController
  def index
    if current_user
      render 'dashboard' 
    else
      render 'index'
    end
  end
  
end

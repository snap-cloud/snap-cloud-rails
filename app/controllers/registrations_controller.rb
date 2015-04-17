class RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    @user = User.create(user_params)
    if @user.save
      status = { :code => 0}
      data = @user
    else
      status = { :code => 1, :messages => @user.errors.full_messages }
      data = nil 
    end
    respond_to do |format|
      format.json {
        render :json => {:state =>  status, :data => data}
      }
      format.html {
        redirect_to '/', :state => status, :data => data
      }
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :username, :password)
  end

end
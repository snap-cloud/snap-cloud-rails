class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :token_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable
end

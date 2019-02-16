class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
	devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :validatable
 	validates :first_name, :last_name, :email, :address, :city, :state, :zip, presence: true

 	with_options dependent: :destroy do
 		has_many :cards
 	end	
end

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

   	validates :first_name, presence: true
    validates :last_name, presence: true
    validates :email, presence: true
    validates :email, uniqueness: true
    validates :date_of_birth, presence: true
    validates :password, presence: true
    validates :password_confirmation, presence: true

    mount_uploader :baby, BabyUploader

    class << self
      def authenticate(email, password)
        user = User.find_for_authentication(email: email)
        user.try(:valid_password?, password) ? user : nil
      end
    end

end

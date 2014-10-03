class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable

  has_many :services, class_name: 'UserService', dependent: :destroy

  def self.new_for_oauth(opts = {})
    user = opts.slice(:email, :nickname, :name)
    user[:password] = SecureRandom.hex(10)

    User.new user
  end
end

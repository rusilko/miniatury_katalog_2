# == Schema Information
#
# Table name: users
#
#  id              :integer         not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  password_digest :string(255)
#  remember_token  :string(255)
#  admin           :boolean         default(FALSE)
#

class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation
  has_secure_password

  has_many :microposts, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed

  has_many :reverse_relationships, foreign_key: "followed_id", class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: :follower 
    # source here is optional because ails will singularize “followers” 
    # and automatically look for the foreign key follower_id in this case.
    # I’ve kept the :source key to emphasize the parallel structure with the has_many :followed_users

  before_save :create_remember_token
  valid_email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name,  presence: 	true, 
  					        length:   	{ within: 3..50}
      
  validates :email, presence:    true,
                    format: 	   { with: valid_email_regex },
                    uniqueness:  { case_sensitive: false }

  validates :password,  presence: true,
                        length:   { minimum: 6 }
                        
  validates :password_confirmation, presence: true

  def feed
    Micropost.where("user_id = ?", id) #this is equivalent to microposts
  end

  def following?(other_user)
    self.relationships.find_by_followed_id(other_user.id)
  end

  def follow!(other_user)
    self.relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    self.relationships.find_by_followed_id(other_user.id).destroy
  end
    
  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
      # Using self ensures that assignment sets the user’s remember_token so that it will be written to the database along with the other attributes when the user is saved.
      # Because of the way Active Record synthesizes attributes based on database columns, without self the assignment would create a local variable called remember_token
    end
end

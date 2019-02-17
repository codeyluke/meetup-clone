class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true 
  
  has_many :authentications, dependent: :destroy
  has_many :events
 
  has_many :attendees
  has_many :events, :through => :attendees

  enum role: [:member, :admin]
  
  def self.create_with_auth_and_hash(authentication, auth_hash)
    user = User.find_by(email: auth_hash["info"]["email"])
    if !user
      # byebug
      user = self.create!(
      first_name: auth_hash["info"]["first_name"],
      last_name: auth_hash["info"]["last_name"],
      email: auth_hash["info"]["email"],
      password: SecureRandom.hex(10)
      )
      user.save
    end
    user.authentications << authentication
    return user
  end

  # grab google to access google for user data
  def google_token
    x = self.authentications.find_by(provider: 'google_oauth2')
    return x.token unless x.nil?
  end

  after_initialize do
    if self.new_record?
      self.role ||= :member
    end
  end
end

# A user can be in many topics and many posts
class User < ActiveRecord::Base
  has_many :topics
  has_many :posts

  # Validations for registering. 
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }


  has_secure_password
  validates :password, length: { minimum: 6},
                       :on => :create


# Attaching an avatar and resizing it. 
has_attached_file :avatar,
      :styles => { :normal => "250x300>" },
      :url => "/images/profiles/:attachment/:id_:style.:extension",
      :path => ":rails_root/public/images/profiles/:attachment/:id_:style.:extension",
      :default_url => "/images/profiles/avatars/resize-default.jpg"


  # Finding the age from the year. Ages every year. 
  def age(dob)
    if dob != nil
      age = Date.today.year - dob.year
      age -= 1 if Date.today < dob + age.years
      return "(" + age.to_s + " years old)"
    end
  end

  # validate :check_password, :on => :update

  # def check_password
  #   if  :password.present? || :password_confirmation.present?
  #     validate :password, length: { minimum: 6 }
  #   end
  # end

 
  # Make random token for each session
  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private
  # Creates the token. 
    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end

end
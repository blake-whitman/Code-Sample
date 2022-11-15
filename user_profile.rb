class User_profile < ActiveRecord::Base

  attr_accessor :password
  # Used for encrypting and, eventually, clearing a pword
  before_save :encrypt_password
  after_save :clear_password
  
  # Email format in regex
  REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i
  validates :username, :presence => true, :uniqueness => true, :length => { :in => 7..20 }
  validates :email, :presence => true, :uniqueness => true, :format => REGEX
  validates :password, :confirmation => true
  # ensures that the length is in the specified range
  validates_length_of :password, :in => 7..20, :on => :create
  attr_accessible :username, :email, :password, :password_confirmation

  def self.auth(username_or_email, login_password)
    if REGEX.match(username_or_email)    
      user_profile = User_profile.find_by_email(username_or_email)
    else
      user_profile = User_profile.find_by_username(username_or_email)
    end

    if user_profile && user_profile.match_password(login_password)
      return user_profile
    return false
  end

  def match_password(login_password)
    encrypted_password == BCrypt::Engine.hash_secret(login_password, salt)
  end
    
  def clear_password
    self.password = nil
  end

  def encrypt_password
    salt = BCrypt::Engine.generate_salt
    encrypted_password = BCrypt::Engine.hash_secret(password, salt)
  end
end
  

class User < ActiveRecord::Base
  belongs_to :nurse
  belongs_to :student
  belongs_to :administrator
  belongs_to :guardian

  has_secure_password

  before_validation :create_password, on: :create

  before_save {|user| user.email=user.email.downcase.strip}
  before_save :create_session_token

  validates :first_name, presence: true
  validates :last_name, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
            format: {with: VALID_EMAIL_REGEX},
            uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: 3}, on: :create

  private
  def create_session_token
    self.session_token = SecureRandom.urlsafe_base64
  end

  private
  def create_password
    if not self.password
      self.password = (0...8).map { (65 + rand(26)).chr }.join
    end
  end
end

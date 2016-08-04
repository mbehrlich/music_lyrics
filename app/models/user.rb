class User < ActiveRecord::Base
  attr_reader :password

  has_many :notes,
    dependent: :destroy

  after_initialize :ensure_session_token
  validates :email, :session_token, presence: true, uniqueness: true
  validates :password_digest, presence: { message: "Password must be present" }
  validates :password, length: { minimum: 8, allow_nil: true }

  def self.generate_session_token
    SecureRandom::urlsafe_base64(32)
  end

  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
    self.session_token
  end

  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end

  def password=(password)
    pw_dig = BCrypt::Password.create(password)
    self.password_digest = pw_dig
  end

  def is_password?(password)
    pw_dig = BCrypt::Password.new(self.password_digest)
    pw_dig.is_password?(password)
  end

  def self.find_by_credentials(email, password)
    user = User.find_by(email: email)
    return nil if user.nil?
    user.is_password?(password) ? user : nil
  end
end

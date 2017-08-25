class User < ApplicationRecord
  attr_reader :password

  validates :username, :session_token, presence: true, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }
  validates :password_digest, presence:true

  after_initialize :ensure_session_token

  has_many :cats,
    foreign_key: :user_id,
    class_name: :Cat

  def reset_session_token!
    self.session_token = SecureRandom::urlsafe_base64
    self.save!
  end

  def password=(pw)
    @password = pw
    self.password_digest = BCrypt::Password.create(pw)
  end

  def is_password?(pw)
    BCrypt::Password.new(password_digest).is_password?(pw)
  end

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    return nil unless user
    user.is_password?(password) ? user : nil
  end

  def ensure_session_token
    self.session_token ||= SecureRandom::urlsafe_base64
  end
end

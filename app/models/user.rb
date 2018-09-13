class User < ApplicationRecord
	has_secure_password

  validates :name, presence: {message: '用户名必须存在'}
  validates :name, length: {maximum: 32, too_long: "%{count} 用户名超长" }
	validates :password, length: { in: 6..10, message: '密码长度必须6到10位'}
  validates_confirmation_of :password
	validates :email, presence: {message: '邮箱必须存在'}
	validates :email, uniqueness: {message: '邮箱已经被注册'}
	validates :email, format: { with: /\A[a-zA-Z0-9_.-]+@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*\.[a-zA-Z0-9]{2,6}\z/,
    message: "邮箱格式不正确" }

  before_create :generate_authentication_token

  def generate_authentication_token
		loop do
      self.authentication_token = SecureRandom.base64(64)
      break if !User.find_by(authentication_token: authentication_token)
    end
  end

  def reset_auth_token!
    generate_authentication_token
    save
  end
end
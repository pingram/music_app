# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string(255)      not null
#  password_digest :string(255)      not null
#  token           :string(255)      not null
#  created_at      :datetime
#  updated_at      :datetime
#

class User < ActiveRecord::Base
	attr_reader :password

	validates :email, presence: true, uniqueness: true
	validates :password_digest, :presence => { :message => "Password can't be blank" }
	validates :password, length: { minimum: 6, allow_nil: true }
	before_validation :ensure_token

	def self.generate_token

	end

	def ensure_token
		self.token ||= self.class.generate_token
	end

	def password=(pt)
		@password = pt
		self.password_digest = BCrypt::Password.create(pt)
	end

	def is_password?(pt)
		BCrypt::Password.new(self.password_digest).is_password?(pt)
	end

	def self.find_by_credentials(email, pt)
		user = User.find_by_email(email)
		return nil if user.nil?
		user.is_password?(pt) ? user : nil
	end
end
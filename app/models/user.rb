class User < ActiveRecord::Base
	attr_reader :password

	validates :email, presence: true, uniqueness: true
	validates :password_digest, :presence => { :message => "Password can't be blank" }
	validates :password, length: { minimum: 6, allow_nil: true }
	before_validation :ensure_token

	has_many :notes

	def self.generate_token
		SecureRandom::urlsafe_base64(16)
	end

	def reset_token!
		self.token = self.class.generate_token
		self.save!
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
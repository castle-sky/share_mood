class User < ApplicationRecord
	before_save {self.email.downcase!}
	VALID_EMAIL_REG = /\A[0-9a-zA-Z.+-]+@[\w]+(\.[\w]+)*\.[\w]+\z/
	validates :name, presence: true, length: {maximum: 20}
	validates :email, presence: true, length: {maximum: 100},
						format: {with: VALID_EMAIL_REG},
						uniqueness: {case_sensitive: false}
	has_secure_password
	validates :password, presence: true, length: {minimum: 6}
end

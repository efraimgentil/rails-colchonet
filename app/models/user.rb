# encoding: utf-8
class User < ActiveRecord::Base
	# default_scope where('confirmed_at IS NOT NULL')
	scope :confirmed, where('confirmed_at IS NOT NULL')
	scope :most_recent, order('created_at DESC')
	scope :form_sampa, where(:location => 'São Paulo')
	scope :from, ->(location) { where(:location => location ) }
	#Exemplo de uso User.from("Cidade")  ou #Exemplo de uso User.from("Cidade").limit 1

	validates_presence_of :email, :full_name, :location
	#:password
	#validates_confirmation_of :password
	validates_length_of :bio, :minimum => 30, :allow_blank => false
	validates_format_of :email, :with =>/\A[^@]+@([^@\.]+\.)+[^@\.]+\z/
	validates_uniqueness_of :email

	has_secure_password

	before_create :generate_token

  def self.authenticate( email , password)
  	
  	confirmed.find_by_email(email).try(:authenticate , password)
  	
  end

	def generate_token
		self.confirmation_token = SecureRandom.urlsafe_base64
	end

	def confirm!
		return if confirmed?

		self.confirmed_at = Time.current
		self.confirmation_token = ''
		save!
	end

	def confirmed?
		confirmed_at.present?
	end





end

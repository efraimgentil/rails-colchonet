class UserSession
  include ActiveModel::Validations
  include ActiveModel::Conversion

  extend ActiveModel::Naming
  extend ActiveModel::Translation

  validates_presence_of :email, :password

  def initialize ( session , attributes = {} )
    @session = session;
    @email = attributes[:email]
    @password = attributes[:password]
  end

  def authenticate
    user = User.authenticate(@email , @password)
    if user.present?
      store(user)
    else
      errors.add(:base , :invalid_login)
      false
    end
  end

  def destroy
    @session[:user_id] = nil;
  end

  def store(user)
    @session[:user_id] = user.id
  end

  def current_user
    User.find(@session[:user_id])
  end

  def user_signed_in?
    @session[:user_id].present?
  end

  def password! password
    @password = password
  end

  def password
    @password
  end

  def email! email
    @email = email
  end

  def email
    @email
  end

  def persisted?
    false 
  end
end
class SingupMailer < ActionMailer::Base
	
	default :from => 'no-replu@colcho.net'

	def confirm_email(user)
		@user = user
		@confirmation_link = confirmation_url({ :token => @user.confirmation_token }) #Mudar depois

		mail({
			:to => user.email,
			:bcc => ['sign ups <efraim.gentil@gmail.com>'],
			:subject => I18n.t('singup_mailer.confirm_email.subject')

		})
	end

end
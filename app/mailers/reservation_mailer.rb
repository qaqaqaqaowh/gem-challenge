class ReservationMailer < ApplicationMailer
	def spam_email(user)
	    @user = user
	    # delivery_options = { user_name: company.smtp_user,
     #                     password: company.smtp_password,
     #                     address: company.smtp_host }

	    mail(to: @user.email, subject: 'HueHueHue') do |format|
	    	format.html
      		format.text
      	end
 	end
end
class UserMailer < ActionMailer::Base
  default from: "noreply@phil_rocks.com"

  def activation_email(user)
  	@user = user
  	mail(to: user.email, subject: 'Music App Activation Link')
  end
end

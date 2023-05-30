class UserMailer < ApplicationMailer
  default from: 'smartvacay@outlook.com'

def welcome
  @user = params[:user]
  mail(to: @user.email, subject: 'Thank you for joining SmartVacay')
  # This will render a view in `app/views/user_mailer`!
end
  # To test this code in console you can use the bolow code (assign user to user instance first)
  # UserMailer.with(user: user).welcome(user.email).deliver_now

end

class UserMailer < ApplicationMailer
  default from: 'smartvacay@outlook.com'


  def trip
    @user = params[:user]
    mail(to: @user.email, subject: 'Your new SmartVacay Trip has been created')
  # To test:
  # user = User.find(28)
  # UserMailer.with(user: user).trip.deliver_now
  end

end

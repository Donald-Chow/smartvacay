class UserMailer < ApplicationMailer
  default from: 'smartvacay@outlook.com'

  def welcome(recipient)
    @recipient = recipient
    mail(to: recipient,
    subject: "[Signed up] Welcome #{recipient}")
  end
end

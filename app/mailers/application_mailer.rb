class ApplicationMailer < ActionMailer::Base
  default from: "smartvacay@outlook.com"
  layout 'mailer'

  def welcome(recipient)
    @recipient = recipient
    mail(to: recipient,
    subject: "[Signed up] Welcome #{recipient}")
  end
end

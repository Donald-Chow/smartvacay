


ActionMailer::Base.smtp_settings = {
  address:        'smtp-mail.outlook.com', # default: localhost
  port:           '587',                  # default: 25
  user_name:      ENV['OUTLOOK_ADDRESS'],
  password:       ENV['OUTLOOKL_APP_PASSWORD'],
  authentication: :login,                 # :plain, :login or :cram_md5
  enable_starttls_auto: true
}

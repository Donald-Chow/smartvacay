


ActionMailer::Base.smtp_settings = {
  address:        'smtp-mail.outlook.com', # default: localhost
  port:           '25',                  # default: 25
  user_name:      ENV['OUTLOOK_ADDRESS'],
  password:       ENV['OUTLOOK_APP_PASSWORD'],
  authentication: :login,                 # :plain, :login or :cram_md5
  enable_starttls_auto: true,
}

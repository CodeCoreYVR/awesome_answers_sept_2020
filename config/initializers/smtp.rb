# connect to google's mail server
ActionMailer::Base.smtp_settings = {
  address: "smtp.gmail.com",
  port: "587",
  enable_starttls_auto: true,
  authentication: "plain",
  user_name: ENV["EMAIL_USERNAME"],
  password: ENV["EMAIL_PASSWORD"]
}

# make sure you toggle the less secure setting ON
# Google by default will block less secure apps
# https://myaccount.google.com/lesssecureapps

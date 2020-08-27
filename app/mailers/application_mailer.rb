class ApplicationMailer < ActionMailer::Base
  default from: ENV["env_email"]
  layout "mailer"
end

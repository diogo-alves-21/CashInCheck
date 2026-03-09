class ApplicationMailer < ActionMailer::Base

  default from: Rails.application.credentials.dig(:mailer, :sender)
  layout 'mailer'

end

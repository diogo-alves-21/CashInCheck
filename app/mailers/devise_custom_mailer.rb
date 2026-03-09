class DeviseCustomMailer < Devise::Mailer

  helper  :application # helpers defined within `application_helper`
  include Devise::Controllers::UrlHelpers # eg. `confirmation_url`
  layout 'mailer'

end

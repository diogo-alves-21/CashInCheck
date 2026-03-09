# config/initializers/session_store.rb
Rails.application.config.session_store :cookie_store,
                                       key: "_cash_in_check_session",
                                       secure: Rails.env.production?,
                                       same_site: Rails.env.production? ? :none : :lax,
                                       httponly: true # Keep HttpOnly for security

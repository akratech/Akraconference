# This file is part of Mconf-Web, a web application that provides access
# to the Mconf webconferencing system. Copyright (C) 2010-2015 Mconf.
#
# This file is licensed under the Affero General Public License version
# 3 or later. See the LICENSE file.

Mconf::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request.  This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false
  config.action_mailer.perform_deliveries = true


  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false

  config.action_mailer.default_url_options = {:host => '127.0.0.1', :port => 3000}

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  # To simulate a production env, uncomment the lines below and commented the others
  # config.assets.compress = true
  # config.assets.css_compressor = :yui
  # config.assets.debug = false
  config.assets.compress = false # Do not compress assets
  config.assets.debug = true # Expands the lines which load the assets

  config.eager_load = false

#   config.action_mailer.smtp_settings = {
#       :address              => "smtp.gmail.com",
#       :port                 => 587,
#       :domain               => "gmail.com",
#       :user_name            => "toarvindmehra@gmail.com",
#       :password             => "September@21",
#       :authentication       => 'plain'
# }

  config.action_mailer.smtp_settings = {
    :authentication => :plain,
    :address => "smtp.mailgun.org",
    :port => 587,
    :domain               => "atconference.online",
    :user_name            => "postmaster@atconference.online",
    :password             => "13885d4abd5775d1e404154cd37c3d42"
  }

  config.after_initialize do
    ActiveMerchant::Billing::Base.mode = :test
    paypal_options = {
      login: "jb-us-seller_api1.paypal.com",
      password: "WX4WTU3S8MY44S7F",
      signature: "AFcWxV21C7fd0v3bYYYRCpSSRl31A7yDhhsPUU2XhtMoZXsWHFxu-RWy"
    }
    ::EXPRESS_GATEWAY = ActiveMerchant::Billing::PaypalExpressGateway.new(paypal_options)
  end
end

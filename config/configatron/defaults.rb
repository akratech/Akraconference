# coding: utf-8
# This file is part of Mconf-Web, a web application that provides access
# to the Mconf webconferencing system. Copyright (C) 2010-2015 Mconf.
#
# This file is licensed under the Affero General Public License version
# 3 or later. See the LICENSE file.

# Put all your default configatron settings here.

# Example:
#   configatron.emails.welcome.subject = 'Welcome!'
#   configatron.emails.sales_reciept.subject = 'Thanks for your order'
#
#   configatron.file.storage = :s3

# Make sure the config file exists and load it
CONFIG_FILE = File.join(::Rails.root, "config", "setup_conf.yml")
unless File.exists? CONFIG_FILE
  puts
  puts "ERROR"
  puts "The configuration file does not exist!"
  puts "Path: #{CONFIG_FILE}"
  puts
  exit
end

# Load the configuration file into configatron
full_config = YAML.load_file(CONFIG_FILE)
config = full_config["default"]
config_env = full_config[Rails.env]
config.merge!(config_env) unless config_env.nil?
configatron.configure_from_hash(config)

# Defaults for redis
configatron.redis.host = 'localhost' if configatron.redis.host.nil?
configatron.redis.port = 6379 if configatron.redis.port.nil?
configatron.redis.db = 0 if configatron.redis.db.nil?

# Translations for the languages available. The names of the languages are not
# translated, so it's better to have them here than in the locale files.
# See `config.i18n.available_locales` in `config/application.rb`
configatron.locales.names = {
  de: "Deutsch",
  en: "English",
  "es-419": "Español",
  "pt-br": "Português"
}

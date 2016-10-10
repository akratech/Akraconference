require 'net/http'
class QueryMailer < ActionMailer::Base

  def get_in_touch(name,email,number,message)
    email_id = Rails.env.production? ? "admin@atconference.online" : "bloomberg490@gmail.com"
    subject = "Query from #{name} phone number: #{number}"
    @body = "#{message}"
    mail(:to => email_id,:subject => subject,:from => email)
  end

  def contact_us(name,email,subject,message)
    email_id = Rails.env.production? ? "admin@atconference.online" : "bloomberg490@gmail.com"
    subject = subject
    @body = "#{message}"
    mail(:to => email_id,:subject => subject,:from => email)
  end

end
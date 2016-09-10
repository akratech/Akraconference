require 'net/http'
class QueryMailer < ActionMailer::Base

  def get_in_touch(name,email,number,message)
    subject = "Query from #{name} phone number: #{number}"
    @body = "#{message}"
    mail(:to => "contact@akra-tech.com",:subject => subject,:from => email)
  end

end
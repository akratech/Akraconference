require 'net/http'
class QueryMailer < ActionMailer::Base

	def get_in_touch(name,email,number)
	    subject = "Query from #{name}"
	    @body = "Query from #{name} phone number: #{number}"
	    mail(:to => "bloomberg490@gmail.com",:subject => subject,:from => email)
  end

end
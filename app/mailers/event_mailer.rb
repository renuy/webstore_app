class EventMailer < ActionMailer::Base
  default :from => "mc@strataretail.co"
  default :reply_to => "mc@justbooksclc.com"
  def registration_confirmation(event)
    @url = 'http://www.justbooksclc.com'
    @event = event
    mail(:to => "info@justbooksclc.com", :subject => "Justbooks:Powai")    
  end

end

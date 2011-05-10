class SignupMailer < ActionMailer::Base
  default :from => "mc@strataretail.co"
  default :reply_to => "mc@justbooksclc.com"
  def registration_confirmation(signup)
    @url = 'http://www.justbooksclc.com'
    @signup = signup
    mail(:to => signup.email, :subject => "Welcome To JustBooks", :cc=>signup.branch.email)    
  end

end

class RenewalMailer < ActionMailer::Base
  default :from => "mc@strataretail.co"
  default :reply_to => "mc@justbooksclc.com"
  def renewal_confirmation(renewal)
    @url = 'http://www.justbooksclc.com'
    @renewal = renewal
    mail(:to => renewal.member.user.email, :subject => "JustBooks : Membership Renewed", :cc=>renewal.member.branch.email)    
  end

end

class MempSignup < ActiveRecord::Base

  after_create { generateSignupEvent }
  
  def generateSignupEvent
    eventObj = MempEvent.new

    eventObj.event_type = "SIGNUP"
    eventObj.version = "1"
    eventObj.status = "P"
    eventObj.val1 = self.membership_no
    eventObj.val2 = self.branch_id
    eventObj.val3 = self.email
    eventObj.val4 = self.name
    eventObj.val5 = self.created_by
    eventObj.val6 = self.mphone
    eventObj.val7 = self.lphone
    eventObj.val8 = self.referrer_member_id
    eventObj.val9 = self.plan_id
    eventObj.val10 = self.start_date
    eventObj.val11 = self.expiry_date
    eventObj.val12 = self.employee_no
    eventObj.val13 = self.security_deposit
    eventObj.val14 = self.registration_fee
    eventObj.val15 = self.reading_fee
    eventObj.val16 = self.discount
    eventObj.val17 = self.advance_amt
    eventObj.val18 = self.created_at
    eventObj.val19 = self.overdue_amt
    eventObj.val20 = self.paid_amt
    eventObj.val21 = self.signup_months
    eventObj.val22 = self.payment_mode
    eventObj.val23 = self.payment_ref
    eventObj.val24 = self.remarks
    eventObj.val25 = self.coupon_amt
    eventObj.val26 = self.coupon_no
    eventObj.val27 = self.company_id
    eventObj.val28 = self.address
    eventObj.val29 = self.id
    eventObj.save
    
    if !self.referrer_member_id.blank? && Plan.find(self.plan_id).referrals_allowed == 'Y'
      eventObj1 = Event.new

      eventObj1.event_type = "REWARD_POINTS"
      eventObj1.version = "1"
      eventObj1.status = "P"
      eventObj1.val1 = self.referrer_member_id
      card = Card.find_by_membership_no(self.referrer_member_id)
      eventObj1.val2 = card.branch_id
      eventObj1.val3 = self.created_at
      eventObj1.val4 = self.plan_id
      eventObj1.val5 = self.created_by
      eventObj1.val6 = self.membership_no
      eventObj1.save
    end
  end
    def generateNMReversalEvent
    eventObj = Event.new

    eventObj.event_type = "NEW_MEMBER_REVERSAL"
    eventObj.version = "1"
    eventObj.status = "P"
    eventObj.val1 = self.membership_no
    eventObj.val2 = self.created_by
    eventObj.val3 = self.branch_id
    eventObj.val4 = self.address
    eventObj.val5 = self.advance_amt
    eventObj.val6 = self.application_no
    eventObj.val7 = self.branch_id
    eventObj.val8 = self.coupon_amt
    eventObj.val9 = self.coupon_id
    eventObj.val10 = self.coupon_no
    eventObj.val11 = self.discount
    eventObj.val12 = self.email
    eventObj.val13 = self.employee_no
    eventObj.val14 = self.expiry_date
    eventObj.val15 = self.lphone
    eventObj.val16 = self.mphone
    eventObj.val17 = self.name
    eventObj.val18 = self.overdue_amt
    eventObj.val19 = self.paid_amt
    eventObj.val20 = self.payment_mode
    eventObj.val21 = self.payment_ref
    eventObj.val22 = self.plan_id
    eventObj.val23 = self.reading_fee
    eventObj.val24 = self.referrer_member_id
    eventObj.val25 = self.registration_fee
    eventObj.val26 = self.remarks
    eventObj.val27 = self.security_deposit
    eventObj.val28 = self.signup_months
    eventObj.val29 = self.start_date
    eventObj.val30 = self.flag_migrated

    eventObj.save

    # generate event for reward points reversal
    if !self.referrer_member_id.blank? && Plan.find(self.plan_id).referrals_allowed == 'Y'
      eventObj1 = Event.new

      eventObj1.event_type = "REWARD_POINTS_REVERSAL"
      eventObj1.version = "1"
      eventObj1.status = "P"
      eventObj1.val1 = self.referrer_member_id
      card = Card.find_by_membership_no(self.referrer_member_id)
      eventObj1.val2 = card.branch_id
      eventObj1.val3 = self.created_at
      eventObj1.val4 = self.plan_id
      eventObj1.val5 = self.created_by
      eventObj1.val6 = self.membership_no
      eventObj1.save
    end
  end

end

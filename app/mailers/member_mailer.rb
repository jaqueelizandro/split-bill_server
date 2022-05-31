class MemberMailer < ApplicationMailer
    default from: 'split@gmail.com'

    def welcome_email
        @member = params[:member]
        @url  = 'http://example.com/login'
        mail(to: @member.email, subject: 'Welcome to Split')
      end
end

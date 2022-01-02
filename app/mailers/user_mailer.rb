class UserMailer < ApplicationMailer
  default from: 'invite@tracker.com'

  def welcome_email(user, pass)
    @user = user
    @pass = pass
    @url  = 'https://localhost:3000/login'
    mail(to: user.email, subject: 'Welcome to our Page!')
  end

  def missed_meeting_email(user, meeting)
    @user = user
    @meeting = meeting
    mail(to: user.email, subject: 'Missed Meeting!')
  end
end

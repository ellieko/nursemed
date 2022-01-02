require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  it 'check email contents for welcome' do
    user = User.find(1)
    password = "12345"
    # Set up an email using the order contents
    email  = UserMailer.welcome_email(user, password)
    # Check the contents are correct
    expect(email.from).to eq(['invite@tracker.com'])
    expect(email.to).to eq(['atro@phy.com'])
    expect(email.subject).to match("Welcome to our Page!")
    expect(email.body.to_s).to match(user.first_name)
    expect(email.body.to_s).to match(password)

  end
  it 'check email contents for missed meeting' do
    user = User.find(1)
    meeting = Meeting.find(1)
    # Set up an email using the order contents
    email  = UserMailer.missed_meeting_email(user, meeting)
    # Check the contents are correct
    expect(email.from).to eq(['invite@tracker.com'])
    expect(email.to).to eq(['atro@phy.com'])
    expect(email.subject).to match("Missed Meeting!")
    expect(email.body.to_s).to match(user.last_name)
    expect(email.body.to_s).to match(meeting.date.to_s)
    expect(email.body.to_s).to match(meeting.student.user.first_name)
    expect(email.body.to_s).to match(meeting.nurse.user.last_name)

  end
end

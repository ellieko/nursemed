Given('the following meeting between student and nurse') do |meetings|
  meetings.hashes.each do |meetings|
    Meeting.create!(meetings)
  end

end

Given('he following user have been added to the tracker:') do |user|
    user.hashes.each do |user|
      User.create!(user)
      end
  end

When('Nurse is on the meetings details page') do
  visit nurse_meeting_path(1,1)
end

When('clicks on {string}') do |string|
  click_on "#{string}"
end

Then('nurse is redirected to report error page') do
  post("nurses/1/meetings/1/error")

end

When('is on the report error page') do
  get("nurses/1/meetings/1/error")
end

When('clicks button Report Med Error') do
  select  'Wrong Student', from: 'meeting_error'
  fill_in 'meeting_mitigation', :with => 'Error recorded'
  click_on 'Report Med Error'
end

Then('she should be redirected to her meeting page') do
  visit nurse_meeting_path(1,1)
end

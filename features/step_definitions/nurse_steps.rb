# Completed step definitions for AddMeeting

# for AddMeeting.feature

When /^a nurse has added a new meeting schedule with a student whose ID is "(.*?)" on "(.*?)"$/ do |id, date|
  # suppose current user id (nurse_id) is 1
  visit new_nurse_meeting_path(1)
  fill_in 'Student ID', :with => id
  select '2021',  from: 'meeting_date_1i'
  select 'November', from: 'meeting_date_2i'
  select '1', from: 'meeting_date_3i'
  click_button 'Add Schedule'
end

And /^a nurse is on the default meeting Schedule page$/ do
  visit nurse_meetings_path(1)
end

Then /^a user should see a meeting schedule with "(.*?)" on "(.*?)\/(.*?)\/(.*?)"$/ do |id, d1, d2, d3|
  result = false
  all('tr').each do |tr|
    if tr.has_content?(id) && tr.has_content?(d1) && tr.has_content?(d2) && tr.has_content?(d3)
      result = true
      break
    end
  end
  expect(result).to be_truthy
end

When(/^an administrator has added a nurse with name "(.*?) (.*?)" at school "(.*?)"$/) do |first_name, last_name, school_name|
  visit new_nurse_path
  fill_in 'user[first_name]', :with => first_name
  fill_in 'user[last_name]', :with => last_name
  fill_in 'user[email]', :with => "#{first_name}@#{last_name}.com"
  select school_name, :from => 'nurse[school_id]'
  click_button 'Save Changes'
end

And(/^an administrator is on the manage nurses page$/) do
  visit nurses_path
end

Then(/^an administrator should see a nurse called "(.*?) (.*?)" at school "(.*?)"$/) do |first_name, last_name, school_name|
  result = false
  all('tr').each do |tr|
    if tr.has_content?(first_name) && tr.has_content?(last_name) && tr.has_content?(school_name)
      result = true
      break
    end
  end
  expect(result).to be_truthy
end

Then(/^an administrator visits the edit nurse page for "(.*?) (.*?)"$/) do |first_name, last_name|
  visit edit_nurse_path(User.find_by(first_name: first_name, last_name: last_name).nurse_id)
end

When(/^an administrator has edited the info to change the name to "(.*?) (.*?)" at school "(.*?)"$/) do |first_name, last_name, school_name|
  fill_in 'user[first_name]', :with => first_name
  fill_in 'user[last_name]', :with => last_name
  fill_in 'user[email]', :with => "#{first_name}@#{last_name}.com"
  select school_name, :from => 'nurse[school_id]'
  click_button 'Save Changes'
end
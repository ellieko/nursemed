
Given /^the following meetings have been added to the tracker:$/ do |meetings_table|
  meetings_table.hashes.each do |meeting_data|
    meeting_create_hash = meeting_data
    meeting_create_hash["student_id"] = meeting_create_hash["student_id"].to_i
    meeting_create_hash["nurse_id"] = meeting_create_hash["nurse_id"].to_i
    meeting = Meeting.create!(meeting_create_hash)
  end
end


Given /^a guardian is on their schedule page$/ do
  visit login_path
end

# Completed step definitions for AddMeeting

# for AddMeeting.feature

Given /^a nurse is on the Add New Schedule Page$/ do
  visit new_nurse_meeting_path(1)
end

Then /^a nurse should see a student "(.*?) (.*?)"$/ do |first_name, last_name|
  expect(page).to have_content(first_name)
  expect(page).to have_content(last_name)
end

Then /^a nurse should not see a student "(.*?) (.*?)"$/ do |first_name, last_name|
  expect(page).not_to have_content(first_name)
  expect(page).not_to have_content(last_name)
end

And /^a nurse has added new meeting$/ do
  click_on "Add Schedule"
end

Then /^a nurse should see "(.*?)"$/ do |msg|
  expect(page).to have_content(msg)
end

Given /^a nurse has only one meeting with "(.*?)"/ do |name|
  visit nurse_path(1)
  expect(page).to have_content(name, count: 1)
end

Given /^a nurse is on the Meeting Details page with "(.*?)"$/ do |name|
  find('tr', text: name).click_link("Meeting Details")
end

When /^a nurse has clicked Log Meeting Button$/ do
  click_on "Log Meeting"
end

And /^a nurse has visited View History page$/ do
  click_on "View History"
end

When /^a nurse has clicked Cancel Meeting Button$/ do
  click_on "Cancel Meeting"
end

Then /^a nurse should not see the meeting with "(.*?)" anymore$/ do |name|
  result = true
  all('tr').each do |tr|
    if tr.should have_no_content(name)
      result = true
    else
      result = false
      break
    end
  end
  expect(result).to be_truthy
end

And /^a nurse has edited Meeting Information to "(.*?)"$/ do |information|
  click_on "Edit Meeting Details"
  fill_in 'meeting[info]', :with => information
  click_button "Edit Meeting"
end

Then /^a nurse should see the updated page with "(.*?)"$/ do  |information|
  expect(page).to have_content(information)
end

Then /^a nurse should see "A new meeting was successfully scheduled."$/ do
  expect(page).to have_content("A new meeting was successfully scheduled.")
end

And /^a nurse has edited datetime to "(.*?)" "(.*?)"$/ do |date, time|
  pending
  find('div#new-meeting-form', visible: false).set(true)
  within 'div#new-meeting-form' do
    select '2022',  from: 'meeting_date_1i'
    select 'March', from: 'meeting[start(1i)]'
    select '26', from: 'meeting_date_3i'
    select '15', from: 'meeting_date_4i'
    select '00', from: 'meeting_date_5i'
  end
  # new = DateTime.new(year, month, day, hour, minute, 0)
  # select_datetime(new, :id => meeting[start])
  #p page.body
  #select(year, :from => "meeting_start_1i")
  #select(month,:from => "meeting_start_2i")
  #select(day,  :from => "meeting_start_3i")
  #select(hour, :from => "meeting_start_4i")
  #select(minute, :from => "meeting_start_5i")
  click_on "Edit Meeting"
end


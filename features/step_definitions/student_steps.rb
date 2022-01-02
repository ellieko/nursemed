# Completed step definitions for basic features: AddStudent, EditStudent


# for AddStudent.feature
Given /^a nurse is on the Manage Students page$/ do
  visit students_path
end

Given /^a nurse has added a student with name "(.*?) (.*?)", guardian "(.*?) (.*?)"$/ do |first_name, last_name, guardian_first, guardian_last|
  visit new_student_path
  fill_in 'user[first_name]', :with => first_name
  fill_in 'user[last_name]', :with => last_name
  fill_in 'user[email]', :with => first_name+"@"+last_name+".com"
  fill_in 'guardians[first_name]', :with => guardian_first
  fill_in 'guardians[last_name]', :with => guardian_last
  fill_in 'guardians[email]', :with => guardian_first+"@"+guardian_last+".com"
  click_button 'Save Changes'
end

# for DeleteStudent.feature
When ('I click on Delete') do
  click_on 'Delete'
end

Then /^I should see the index page without "(.*?) (.*?)"$/ do |first_name, last_name|
  visit students_path
  result = false
  all('tr').each do |tr|
    if tr.should have_no_content(first_name)
      result = true
      break
    end
  end
  expect(result).to be_truthy
end


# for EditStudent.feature
And /^a nurse has visited the Details about "(.*?) (.*?)" page$/ do |first_name, last_name|
  visit students_path
  click_on "More about #{first_name} #{last_name}"
end

When /^a nurse has edited the info of "(.*?) (.*?)" to change the guardian to "(.*?)"$/ do |first_name, last_name, guardian|
  guard_first_name = guardian.split()[0]
  guard_last_name = guardian.split()[1]
  click_on 'Edit'
  fill_in 'guardians[first_name]', :with => guard_first_name
  fill_in 'guardians[last_name]', :with => guard_last_name
  click_button 'Update Student Info'
end

When /^a nurse has edited the info to change the name to "(.*?) (.*?)"$/ do |new_first, new_last|
  click_on 'Edit'
  fill_in 'user[first_name]', :with => new_first
  fill_in 'user[last_name]', :with => new_last
  click_button 'Update Student Info'
end


When /^an admin has transferred to "(.*?)"$/ do |new_school|
  click_on 'Transfer'
  select new_school,  from: 'school'
  click_button 'Save Changes'
end

Then /^a nurse should see a student list entry with name "(.*?) (.*?)" and guardian "(.*?)"$/ do |first_name, last_name, guardian|
  result = false
  all('tr').each do |tr|
    if tr.has_content?(first_name) && tr.has_content?(last_name) && tr.has_content?(guardian)
      result = true
      break
    end
  end
  expect(result).to be_truthy
end

# for AssignMedication.feature
Given /^a nurse has added a medication called "(.*?)" to student with name "(.*?) (.*?)"$/ do
  |medication_name, student_first_name, student_last_name|
  visit students_path
  click_on "More about #{student_first_name} #{student_last_name}"
  click_on "Student Medications"
  click_on "Assign Medication"
  select medication_name, :from => 'medication_assignment[medication_id]'
  click_on "Assign Medication"
end

Given /^a nurse is on the medication list for the student "(.*?) (.*?)"$/ do |student_first_name, student_last_name|
  visit students_path
  click_on "More about #{student_first_name} #{student_last_name}"
  click_on "Student Medications"
end

Then /^a nurse should see a medicine entry called "([^"]*)"$/ do |medication_name|
  result = false
  all('tr').each do |tr|
    if tr.has_content?(medication_name)
      result = true
      break
    end
  end
  expect(result).to be_truthy
end

# for StopMedication.feature
When /^a nurse has visited the details page about a medication assignment for "([^"]*)"$/ do |medication_name|
  click_on "More about #{medication_name}"
end

When /^I click on Stop Medication$/ do
  click_on "Stop Medication"
end

Then /^I should see medication list without "([^"]*)"$/ do |medication_name|
  result = false
  all('tr').each do |tr|
    if tr.should have_no_content(medication_name)
      result = true
      break
    end
  end
  expect(result).to be_truthy
end

# for EditMedicationAssignment.feature

When /^a nurse has edited the info of "([^"]*)" to change the medicine to "([^"]*)"$/ do
|medication_name, new_medication_name|
  click_on 'Edit'
  select new_medication_name, :from => 'medication_assignment[medication_id]'
  click_on 'Update Medication'
end
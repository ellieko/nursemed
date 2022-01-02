
Then /^a nurse should see a list of students$/ do
  expect(page).to have_content("All Students")
end

When /^an user visits students index$/ do
  visit students_path
end

When /^an user visits students new$/ do
  visit new_student_path
end

When /^an user visits nurses$/ do
  visit nurses_path
end
When /^an user visits schools index page$/ do
  visit schools_path
end


When /^an user visits nurses show page$/ do
  visit nurse_path(1)
end

Then /^an administrator should see nurses list$/ do
  expect(page).to have_content("All Nurses")
end

When /^an user should see nurse info$/ do
  expect(page).to have_content("Details")
end

When('an user visits medication index') do
  visit medications_path
end

Then('an user should see a list of medications') do
  expect(page).to have_content("Medications")
end

When('an user visits medication new page') do
  visit new_medication_path
end

Then('an user should see a medication form') do
  expect(page).to have_content("Add Medication")
end

When('an user visits medication assignments page') do
  visit student_medication_assignments_path(1)
end

When('an user visits new medication assignments page') do
  visit new_student_medication_assignment_path(1)
end
When('an user visits meeting show page') do
  visit nurse_meeting_path(1,1)
end

When('an user visits new meeting page') do
  visit new_nurse_meeting_path(1)
end


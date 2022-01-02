When(/^an administrator has added a medication called "([^"]*)" with true name "([^"]*)" and dosage "([^"]*)"$/) do
  |med_name, med_true_name, med_dosage|
  visit new_medication_path
  fill_in 'medication[name]', :with => med_name
  fill_in 'medication[dosage]', :with => med_dosage
  fill_in 'medication[true_name]', :with => med_true_name
  click_button 'Add Medication'
end

And(/^an administrator is on the manage medications page$/) do
  visit medications_path
end

Then(/^an administrator should see a medication entry called "([^"]*)" and dosage "([^"]*)"$/) do
  |med_name, med_dosage|
  result = false
  all('tr').each do |tr|
    if tr.has_content?(med_name) && tr.has_content?(med_dosage)
      result = true
      break
    end
  end
  expect(result).to be_truthy
end

And(/^an administrator has visited the details about medication "([^"]*)"$/) do
  |med_name|
  visit medications_path
  click_on "More about #{med_name}"
end

When(/^an administrator has edited the info to change medication "([^"]*)" to "([^"]*)"$/) do
  |med_name, med_name_new|
  click_on 'Edit'
  fill_in 'medication[name]', :with => med_name_new
  click_button 'Update Medication'
end
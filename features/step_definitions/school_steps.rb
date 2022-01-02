When(/^an administrator has added a school called "([^"]*)"$/) do |school_name|
  visit new_school_path
  fill_in 'school[name]', :with => school_name
  click_button 'Add School'
end

And(/^an administrator is on the manage schools page$/) do
  visit schools_path
end

Then(/^an administrator should see a school entry called "([^"]*)"$/) do |school_name|
  result = false
  all('tr').each do |tr|
    if tr.has_content?(school_name)
      result = true
      break
    end
  end
  expect(result).to be_truthy
end

And(/^an administrator has visited the details about school "([^"]*)"$/) do |school_name|
  visit schools_path
  click_on "More about #{school_name}"
end

When(/^an administrator has edited the info to change school "([^"]*)" to "([^"]*)"$/) do |school_name, new_school_name|
  click_on 'Edit'
  fill_in 'school[name]', :with => new_school_name
  click_button 'Update School'
end
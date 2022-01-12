
Given /the following nurses have been added to the tracker:/ do |nurse_table|
  nurse_table.hashes.each do |nurse_data|
    nurse_create_hash = nurse_data.except("first_name", "last_name", "email", "password")
    nurse_create_hash["school_id"] = nurse_create_hash["school_id"].to_i
    nurse = Nurse.create!(nurse_create_hash)
    nurse_data = nurse_data.except("school_id")
    nurse_data["nurse_id"] = nurse.id
    User.create!(nurse_data)
  end
end
Given /the following students have been added to the tracker:/ do |student_table|
  student_table.hashes.each do |student_data|
    student_create_hash = student_data.except("first_name", "last_name", "email", "password")
    student_create_hash["school_id"] = student_create_hash["school_id"].to_i
    student = Student.create!(student_create_hash)
    student_data = student_data.except("birthdate", "school_id")
    student_data["student_id"] = student.id
    User.create!(student_data)
  end
end

Given /the following administrators have been added to the tracker:/ do |administrator_table|
  administrator_table.hashes.each do |administrator_data|

    administrator = Administrator.create!()
    administrator_data["administrator_id"] = administrator.id
    User.create!(administrator_data)
  end
end

Given /the following guardians have been added to the tracker:/ do |guardians_table|
  guardians_table.hashes.each do |guardian_data|

    guardian = Guardian.create!()
    guardian_data["guardian_id"] = guardian.id
    User.create!(guardian_data)
  end
end

Given /an user is on the login page/ do
  visit login_path
end

When /^an user has entered the email "(.+?)" and password "(.+?)"$/ do |email, password|
  fill_in 'Email', :with => email
  fill_in 'Password', :with => password
end

Given /^an user clicks "(.+?)"$/  do |button_text|
  click_on button_text
end



Then /^a student should be redirected to their schedule page$/ do
  expect(page).to have_content("Details")
end

Then /^a guardian should be redirected to their schedule page$/ do
  expect(page).to have_content("Meetings List")
end


Then /^an administrator should be redirected to their schedule page$/ do
  expect(page).to have_content("All Students")
  #expect(page).to have_content("Administrator Schedule")
end

Then /^a nurse should be redirected to their schedule page$/ do
  expect(page).to have_content("NURSE SCHEDULE")
end

Then /^an user should see "(.+?)"$/ do |text|
  expect(page).to have_content(text)
end


Given /^an user has logged in with "(.+?)" and "(.+?)"/ do |email, password|
  visit login_path
  fill_in 'Email', :with => email
  fill_in 'Password', :with => password
  click_on "Log in"
end

Then /^an user should be redirected to the login page$/ do
  expect(page).to have_content("Login")
end
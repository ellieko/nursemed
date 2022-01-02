When /^an user is on "(.+?)" guardian page$/ do |guardian_id|
  visit "/guardians/#{guardian_id}"
end
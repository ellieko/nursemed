# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

schools_data = [{:name => 'Taft School'},
                {:name => 'DZ National School'},
                {:name => 'Gen High School'}]
schools = School.create!(schools_data)

guardians_data = [{}, {}]
guardians = Guardian.create!(guardians_data)

administrator_data = [{}]
administrators = Administrator.create!(administrator_data)


nurses_data = [{:school_id => schools[0].id},
               {:school_id => schools[1].id},
               {:school_id => schools[2].id},
               # adding one more nurse in school 1 - Kaylee
               # to check if a meeting with another nurse within the same school
               # also be shown by Visit History
               {:school_id => schools[0].id}]
nurses = Nurse.create!(nurses_data)

students_data = [{:school_id => schools[0].id, :birthdate => '30-Mar-1992', :guardian_ids => [guardians[0].id, guardians[1].id]},
                 {:school_id => schools[1].id, :birthdate => '20-Apr-1995', :guardian_ids => [guardians[1].id]},
                 {:school_id => schools[2].id, :birthdate => '10-Dec-1997', :guardian_ids => [guardians[0].id]},
                 # adding one more student in school 1 - Brian
                 {:school_id => schools[0].id, :birthdate => '10-Dec-1997', :guardian_ids => [guardians[0].id]}]
students = Student.create!(students_data)


users_data = [{:first_name => 'Atro', :last_name => 'Phy', :password => "12345", :email => 'atro@phy.com', :nurse => nurses[0]},
              {:first_name => 'Inco', :last_name => 'Gnito', :password => "12345", :email => 'inco@gnito.com', :nurse => nurses[1]},
              {:first_name => 'Lemon', :last_name => 'Drop', :password => "23456", :email => 'lemon@drop.com', :nurse => nurses[2]},
              {:first_name => 'David', :last_name => 'Wang', :password => "12345", :email => 'david@wang.com', :student => students[0]},
              {:first_name => 'Stone', :last_name => 'Tip', :password => "12345", :email => 'stone@tip.com', :student => students[1]},
              {:first_name => 'Wild', :last_name => 'Dark', :password => "12345", :email => 'wild@dark.com', :student => students[2]},
              {:first_name => 'Steven', :last_name => 'Steel', :password => "12345", :email => 'steven@steel.com', :guardian => guardians[0]},
              {:first_name => 'Putin', :last_name => 'Vlad', :password => "12345", :email => 'putin@vlad.com', :guardian => guardians[1]},
              # adding one more student and nurse in the same school (school id - 1)
              {:first_name => 'Brian', :last_name => 'Tian', :password => "12345", :email => 'brian@tian.com', :student => students[3]},
              {:first_name => 'Kaylee', :last_name => 'Mia', :password => "23456", :email => 'kaylee@mia.com', :nurse => nurses[3]},
              {:first_name => 'Hell', :last_name => 'Bear', :password => "12345", :email => 'hell@bear.com', :administrator => administrators[0]}]

users = User.create!(users_data)

meetings_data = [{:start => DateTime.new(2021, 12, 8, 10, 00, 0), :student_id => students[0].id, :nurse_id => nurses[0].id, :info => 'Regular Medication'},
                 {:start => DateTime.new(2021, 12, 10, 17, 30, 0), :student_id => students[1].id, :nurse_id => nurses[1].id, :info => 'Regular Medication'},
                 {:start => DateTime.new(2021, 12, 12, 14, 00, 0), :student_id => students[2].id, :nurse_id => nurses[2].id, :info => 'Regular Medication'},
                 {:start => DateTime.new(2021, 12, 13, 11, 30, 0), :student_id => students[0].id, :nurse_id => nurses[0].id, :info => 'Regular Medication'},
                 {:start => DateTime.new(2021, 12, 13, 17, 30, 0), :student_id => students[0].id, :nurse_id => nurses[0].id, :info => 'Regular Medication'},
                 {:start => DateTime.new(2021, 12, 11, 16, 30, 0), :student_id => students[3].id, :nurse_id => nurses[0].id, :info => 'Regular Medication'},
                 {:start => DateTime.new(2021, 12, 20, 17, 30, 0), :student_id => students[3].id, :nurse_id => nurses[3].id, :info => 'Regular Medication'}]

meetings = Meeting.create!(meetings_data)

medication_data = [{:name => 'Tylenol', :dosage => '80 mg', :true_name => 'Acetaminophen'},
                   {:name => 'Advil', :dosage => '60 mg', :true_name => 'Ibuprofen'}]

medications = Medication.create!(medication_data)


medication_assignments_data = [{:medication_id => medications[0].id, :student_id => students[1].id,
                                :nurse_id => nurses[0].id, :start_date => '1-Dec-2021', :end_date => '1-Jan-2022',
                                :amount => '1 tablet', :frequency => 'once per day', :description => 'before lunch'},
                                {:medication_id => medications[1].id, :student_id => students[0].id,
                                 :nurse_id => nurses[0].id, :start_date => '1-Dec-2021', :end_date => '20-Jan-2022',
                                 :amount => '2 tablet', :frequency => 'twice per day'}]

medication_assignments = MedicationAssignment.create!(medication_assignments_data)



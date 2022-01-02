Feature: allow a user to log in
  Background: users have been added to to the tracker
    Given the following nurses have been added to the tracker:
      | first_name | last_name | email | password | school_id |
      | Nurse | Sample | nurse@a.com  | 12345 | 1 |


    Given the following students have been added to the tracker:
      | first_name | last_name | email | password | school_id | birthdate |
      | Student | Sample | student@a.com  | 12345 | 1 | Dec-12-1999                 |


    Given the following administrators have been added to the tracker:
      | first_name | last_name | email | password |
      | Admin | Sample | admin@a.com  | 12345 |


    Given the following guardians have been added to the tracker:
      | first_name | last_name | email | password |
      | Guardian | Sample | guardian@a.com  | 12345 |

  Scenario: nurse visiting student index
    Given an user has logged in with "nurse@a.com" and "12345"
    When an user visits students index
    Then a nurse should see a list of students

  Scenario: guardian visiting student index
    Given an user has logged in with "guardian@a.com" and "12345"
    When an user visits students index
    Then a guardian should be redirected to their schedule page

  Scenario: administrator visiting student index
    Given an user has logged in with "admin@a.com" and "12345"
    When an user visits students index
    Then a nurse should see a list of students

  Scenario: student visiting student index
    Given an user has logged in with "student@a.com" and "12345"
    When an user visits students index
    Then a student should be redirected to their schedule page

  Scenario: student visiting student new
    Given an user has logged in with "student@a.com" and "12345"
    When an user visits students new
    Then a student should be redirected to their schedule page

  Scenario: administrator visiting student new
    Given an user has logged in with "admin@a.com" and "12345"
    When an user visits students new
    Then an administrator should be redirected to their schedule page

  Scenario: administrator visiting nurses index
    Given an user has logged in with "admin@a.com" and "12345"
    When an user visits nurses
    Then an administrator should see nurses list

  Scenario: student visiting nurses index
    Given an user has logged in with "student@a.com" and "12345"
    When an user visits nurses
    Then a student should be redirected to their schedule page


  Scenario: nurse visiting nurses index
    Given an user has logged in with "nurse@a.com" and "12345"
    When an user visits nurses
    Then a nurse should be redirected to their schedule page


  Scenario: nurse visiting nurses show
    Given an user has logged in with "nurse@a.com" and "12345"
    When an user visits nurses show page
    Then an user should see nurse info

  Scenario: administrator visiting nurses show
    Given an user has logged in with "admin@a.com" and "12345"
    When an user visits nurses show page
    Then an user should see nurse info

  Scenario: nurse visiting medication index pages
    Given an user has logged in with "nurse@a.com" and "12345"
    When an user visits medication index
    Then an user should see a list of medications

  Scenario: administrator visiting medication index pages
    Given an user has logged in with "admin@a.com" and "12345"
    When an user visits medication index
    Then an user should see a list of medications

  Scenario: nurse visiting medication medication new pages
    Given an user has logged in with "nurse@a.com" and "12345"
    When an user visits medication new page
    Then a nurse should be redirected to their schedule page

  Scenario: administrator visiting medication pages
    Given an user has logged in with "admin@a.com" and "12345"
    When an user visits medication new page
    Then an user should see a medication form

  Scenario: administrator visiting a schools page
    Given an user has logged in with "admin@a.com" and "12345"
    When an user visits schools index page
    Then an user should see "Taft School"

  Scenario: nurse visiting a schools page
    Given an user has logged in with "nurse@a.com" and "12345"
    When an user visits schools index page
    Then a nurse should be redirected to their schedule page

  Scenario: administrator visiting a medication assignment page
    Given an user has logged in with "admin@a.com" and "12345"
    When an user visits medication assignments page
    Then an user should see "All Medications"

  Scenario: student visiting a wrong medication assignment page
    Given an user has logged in with "student@a.com" and "12345"
    When an user visits medication assignments page
    Then a student should be redirected to their schedule page

  Scenario: nurse visiting a new medication assignment page
    Given an user has logged in with "nurse@a.com" and "12345"
    When an user visits new medication assignments page
    Then an user should see "Assign Medication for Student"

  Scenario: administrator visiting a new medication assignment page
    Given an user has logged in with "admin@a.com" and "12345"
    When an user visits new medication assignments page
    Then an administrator should be redirected to their schedule page

  Scenario: nurse visiting a meeting show page
    Given an user has logged in with "nurse@a.com" and "12345"
    When an user visits meeting show page
    Then an user should see "Meeting Details"

  Scenario: administrator visiting a meeting show page
    Given an user has logged in with "admin@a.com" and "12345"
    When an user visits meeting show page
    Then an user should see "Meeting Details"

  Scenario: nurse visiting a new meeting page
    Given an user has logged in with "nurse@a.com" and "12345"
    When an user visits new meeting page
    Then an user should see "Add New Meeting Schedule"

  Scenario: administrator visiting a new meeting page
    Given an user has logged in with "admin@a.com" and "12345"
    When an user visits new meeting page
    Then an administrator should be redirected to their schedule page

  Scenario: student visiting a wrong meeting page
    Given an user has logged in with "student@a.com" and "12345"
    When an user visits meeting show page
    Then a student should be redirected to their schedule page


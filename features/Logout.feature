Feature: allow a user to log out
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


  Scenario: student logging out
    Given an user has logged in with "student@a.com" and "12345"
    When an user clicks "logout"
    Then an user should be redirected to the login page
    And an user should see "Successfully logged out!"
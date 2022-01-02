


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


  Scenario: nurse logging in
    Given an user is on the login page
    When an user has entered the email "nurse@a.com" and password "12345"
    And an user clicks "Log in"
    Then a nurse should be redirected to their schedule page

  Scenario: guardian logging in
    Given an user is on the login page
    When an user has entered the email "guardian@a.com" and password "12345"
    And an user clicks "Log in"
    Then a guardian should be redirected to their schedule page

  Scenario: administrator logging in
    Given an user is on the login page
    When an user has entered the email "admin@a.com" and password "12345"
    And an user clicks "Log in"
    Then an administrator should be redirected to their schedule page

  Scenario: student logging in
    Given an user is on the login page
    When an user has entered the email "student@a.com" and password "12345"
    And an user clicks "Log in"
    Then a student should be redirected to their schedule page

  Scenario: outsider logging in
    Given an user is on the login page
    When an user has entered the email "fake@a.com" and password " "
    And an user clicks "Log in"
    Then an user should see "Failed to log in"

  Scenario: logging in with github failure
    Given an user is on the login page
    And Github has not been set up
    When an user clicks "Github"
    Then an user should see "Failed to log in"

  Scenario: logging in with github success
    Given an user is on the login page
    And Github has been set up
    When an user clicks "Github"
    Then a nurse should be redirected to their schedule page

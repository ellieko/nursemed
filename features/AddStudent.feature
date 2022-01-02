Feature: allow a nurse to add a new student

  Background: users have been added to to the tracker
    Given the following nurses have been added to the tracker:
    | first_name | last_name | email | password | school_id |
    | Nurse | Sample | nurse@a.com  | 12345 | 1 |

    Given an user has logged in with "nurse@a.com" and "12345"

  Scenario: Add a new student
    When a nurse has added a student with name "Ellie Ko", guardian "Phil Hammer"
    And a nurse is on the Manage Students page
    Then a nurse should see a student list entry with name "Ellie Ko" and guardian "Phil Hammer"

  Scenario: Add a new student email error
    When a nurse has added a student with name "Ellie Ko", guardian "Ellie Ko"
    Then an user should see "Emails need to be unique"

  Scenario: Add a new student email error
    When a nurse has added a student with name "Ellie Ko", guardian "Inco Gnito"
    Then an user should see "Email has already been taken"
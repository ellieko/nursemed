Feature: allow a nurse to edit an existing student information

  Background: users have been added to to the tracker
    Given the following nurses have been added to the tracker:
      | first_name | last_name | email | password | school_id |
      | Nurse | Sample | nurse@a.com  | 12345 | 1 |

    Given an user has logged in with "nurse@a.com" and "12345"

  Scenario: Edit a student information
    Given a nurse has added a student with name "Ted Myers", guardian "Phil Hammer"
    And a nurse has visited the Details about "Ted Myers" page

    When a nurse has edited the info to change the name to "Brian Myers"
    And a nurse is on the Manage Students page
    Then a nurse should see a student list entry with name "Brian Myers" and guardian "Phil Hammer"

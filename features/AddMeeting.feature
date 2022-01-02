Feature: allow a nurse to add a new meeting schedule

  Background: users have been added to to the tracker
    Given the following nurses have been added to the tracker:
      | first_name | last_name | email | password | school_id |
      | Nurse | Sample | nurse@a.com  | 12345 | 1 |

    Given an user has logged in with "atro@phy.com" and "12345"

  Scenario: prevent not selecting a student
    Given a nurse is on the Add New Schedule Page
    And a nurse has added new meeting
    Then a nurse should see "You must select a student to add a schedule."

  Scenario: see a student within the same school
    Given a nurse is on the default Schedule page
    Then a nurse should see a student "David Wang"

  Scenario: do not see a student attending different school
    Given a nurse is on the default Schedule page
    Then a nurse should not see a student "Wild Dark"

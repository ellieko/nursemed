Feature: allow a nurse to edit a meeting details with a student

  Background: users have been added to to the tracker
    Given the following nurses have been added to the tracker:
      | first_name | last_name | email | password | school_id |
      | Nurse | Sample | nurse@a.com  | 12345 | 1 |

    Given an user has logged in with "atro@phy.com" and "12345"
    Given a nurse has only one meeting with "Brian Tian"

  Scenario: edit the meeting information
    Given a nurse is on the Meeting Details page with "Brian Tian"
    And a nurse has edited Meeting Information to "Emergency Prescription"
    Then a nurse should see the updated page with "Emergency Prescription"
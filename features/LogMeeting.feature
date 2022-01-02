Feature: allow a nurse to log a meeting

  Background: users have been added to to the tracker
    Given the following nurses have been added to the tracker:
      | first_name | last_name | email | password | school_id |
      | Nurse | Sample | nurse@a.com  | 12345 | 1 |

    Given an user has logged in with "atro@phy.com" and "12345"
    Given a nurse has only one meeting with "Brian Tian"

  Scenario: log a meeting
    Given a nurse is on the Meeting Details page with "Brian Tian"
    When a nurse has clicked Log Meeting Button
    Then a nurse should not see the meeting with "Brian Tian" anymore

  Scenario: log a canceled meeting
    Given a nurse is on the Meeting Details page with "Brian Tian"
    When a nurse has clicked Cancel Meeting Button
    Then a nurse should not see the meeting with "Brian Tian" anymore

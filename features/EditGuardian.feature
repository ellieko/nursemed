Feature: allow a nurse to edit an existing guardian information

  Background: users have been added to to the tracker
    Given the following nurses have been added to the tracker:
      | first_name | last_name | email | password | school_id |
      | Nurse | Sample | nurse@a.com  | 12345 | 1 |

    Given an user has logged in with "nurse@a.com" and "12345"

  Scenario: Edit a guardian information
    Given a nurse has added a student with name "Stone Tip"
    And a nurse has visited the Details about "Stone Tip" page

    When a nurse has edited the guardian email to "putin1@vlad.com"
    And a nurse has visited the Details about "Stone Tip" page
    Then a nurse should see a guardian email information is updated to "putin1@vlad.com"
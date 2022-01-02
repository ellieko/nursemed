Feature: Reporting and Error

  Background: users have been added to to the tracker
    Given the following nurses have been added to the tracker:
      | first_name | last_name | email | password | school_id |
      | Nurse | Sample | nurse@a.com  | 12345 | 1 |


    Given the following meeting between student and nurse
      | nurse_id | student_id | start        |
      | 1        | 1          |30-Mar-1992  |
      | 1        | 2          |30-Mar-1993  |

    Given the following students have been added to the tracker:
      | first_name | last_name | email | password | school_id | birthdate |
      | Student | Sample | student@a.com  | 12345 | 1 | Dec-12-1999                 |


    Given an user has logged in with "nurse@a.com" and "12345"

  Scenario: Report an Error
    When Nurse is on the meetings details page
    And clicks on "Report Med Error"
    Then nurse is redirected to report error page


  Scenario: Add Error
    When Nurse is on the meetings details page
    And clicks on "Report Med Error"
    And clicks button Report Med Error
    Then she should be redirected to her meeting page


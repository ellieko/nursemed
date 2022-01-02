Feature: allow a nurse to stop a medication for a student

  Background: users have been added to to the tracker
    Given the following nurses have been added to the tracker:
      | first_name | last_name | email | password | school_id |
      | Jane | Doe | nurse@a.com | 12345 | 1 |

    Given the following students have been added to the tracker:
      | first_name | last_name | email | password | birthdate | school_id |
      | John | Smith | student@a.com | 12345 | 1990-10-10 | 1 |

    Given an user has logged in with "nurse@a.com" and "12345"

  Scenario: Stop medication for student
    Given a nurse has visited the Details about "John Smith" page
    And a nurse has added a medication called "Tylenol 80 mg" to student with name "John Smith"
    And a nurse is on the medication list for the student "John Smith"
    When a nurse has visited the details page about a medication assignment for "Tylenol"
    When I click on Stop Medication
    Then I should see medication list without "Tylenol"
Feature: allow a nurse to edit a medication assignment for a student

  Background: users have been added to to the tracker
    Given the following nurses have been added to the tracker:
      | first_name | last_name | email | password | school_id |
      | Jane | Doe | nurse@a.com | 12345 | 1 |

    Given the following students have been added to the tracker:
      | first_name | last_name | email | password | birthdate | school_id |
      | John | Smith | student@a.com | 12345 | 1990-10-10 | 1 |

    Given an user has logged in with "nurse@a.com" and "12345"

  Scenario: Edit a medication for a student
    Given a nurse has visited the Details about "John Smith" page
    When a nurse has added a medication called "Tylenol 80 mg" to student with name "John Smith"
    And a nurse is on the medication list for the student "John Smith"
    And a nurse has visited the details page about a medication assignment for "Tylenol"

    When a nurse has edited the info of "Tylenol" to change the medicine to "Advil 60 mg"
    And a nurse is on the medication list for the student "John Smith"
    Then a nurse should see a medicine entry called "Advil"

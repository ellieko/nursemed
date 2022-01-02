Feature: allow an administrator to add medication

  Background: users have been added to to the tracker
    Given the following administrators have been added to the tracker:
      | first_name | last_name | email | password |
      | Admin | Sample | admin@a.com | 12345 |

    Given an user has logged in with "admin@a.com" and "12345"

  Scenario: Add a medication
    When an administrator has added a medication called "Tylenol" with true name "Acetaminophen" and dosage "10 mg"
    And an administrator is on the manage medications page
    Then an administrator should see a medication entry called "Tylenol" and dosage "10 mg"


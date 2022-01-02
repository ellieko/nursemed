Feature: allow an administrator to add medication

  Background: users have been added to to the tracker
    Given the following administrators have been added to the tracker:
      | first_name | last_name | email | password |
      | Admin | Sample | admin@a.com | 12345 |

    Given an user has logged in with "admin@a.com" and "12345"

  Scenario: Edit a medication
    Given an administrator has added a medication called "Tilenull" with true name "Acetaminophen" and dosage "10 mg"
    And an administrator has visited the details about medication "Tilenull"

    When an administrator has edited the info to change medication "Tilenull" to "Tylanill"
    And an administrator is on the manage medications page
    Then an administrator should see a medication entry called "Tylanill" and dosage "10 mg"
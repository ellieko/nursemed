Feature: allow an administrator to add medication

  Background: users have been added to to the tracker
    Given the following administrators have been added to the tracker:
      | first_name | last_name | email | password |
      | Admin | Sample | admin@a.com | 12345 |

    Given an user has logged in with "admin@a.com" and "12345"

  Scenario: Edit a medication
    Given an administrator has added a school called "West High School"
    And an administrator has visited the details about school "West High School"

    When an administrator has edited the info to change school "West High School" to "East High School"
    And an administrator is on the manage schools page
    Then an administrator should see a school entry called "East High School"


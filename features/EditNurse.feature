Feature: allow an administrator to edit a nurse

  Background: users have been added to to the tracker
    Given the following administrators have been added to the tracker:
      | first_name | last_name | email | password |
      | Admin | Sample | admin@a.com | 12345 |

    Given an user has logged in with "admin@a.com" and "12345"

  Scenario: Edit a nurse
    Given an administrator has added a nurse with name "John Smith" at school "Taft School"
    And an administrator is on the manage nurses page
    Then an administrator visits the edit nurse page for "John Smith"

    When an administrator has edited the info to change the name to "Johnathan Smith" at school "Taft School"
    And an administrator is on the manage nurses page
    Then an administrator should see a nurse called "Johnathan Smith" at school "Taft School"
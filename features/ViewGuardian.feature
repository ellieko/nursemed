Feature: allow only certain people to view guardian pages
  Background: users have been added to to the tracker
    Given the following nurses have been added to the tracker:
      | first_name | last_name | email | password | school_id |
      | Nurse | Sample | nurse@a.com  | 12345 | 1 |

    Given the following administrators have been added to the tracker:
      | first_name | last_name | email | password |
      | Admin | Sample | admin@a.com  | 12345 |

    Given the following students have been added to the tracker:
      | first_name | last_name | email | password | school_id | birthdate |
      | Student | Sample | student@a.com  | 12345 | 1 | Dec-12-1999                 |

    Given the following guardians have been added to the tracker:
      | first_name | last_name | email | password |
      | Guardian | Sample | guardian@a.com  | 12345 |

  Scenario: nurse logging in
    Given an user has logged in with "nurse@a.com" and "12345"
    When an user is on "1" guardian page
    Then an user should see "Meetings List"

  Scenario: correct student logging in
    Given an user has logged in with "david@wang.com" and "12345"
    When an user is on "1" guardian page
    Then an user should see "Steven"

  Scenario: wrong student logging in
    Given an user has logged in with "student@a.com" and "12345"
    When an user is on "1" guardian page
    Then a student should be redirected to their schedule page

  Scenario: correct guardian logging in
    Given an user has logged in with "steven@steel.com" and "12345"
    When an user is on "1" guardian page
    Then an user should see "Steven"

  Scenario: wrong guardian logging in
    Given an user has logged in with "guardian@a.com" and "12345"
    When an user is on "1" guardian page
    Then an user should see "Guardian Sample"
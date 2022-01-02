Feature: allow an admin to transfer students
  Background: users have been added to to the tracker

    Given the following administrators have been added to the tracker:
      | first_name | last_name | email | password |
      | Admin | Sample | admin@a.com  | 12345 |

    Given the following students have been added to the tracker:
      | first_name | last_name | email | password | school_id | birthdate |
      | Student | Sample | student@a.com  | 12345 | 1 | Dec-12-1999       |

    Given an user has logged in with "admin@a.com" and "12345"

    Scenario: Edit a student information
      Given a nurse has visited the Details about "Student Sample" page
      When an admin has transferred to "DZ National School"
      Then an user should see "DZ National School"

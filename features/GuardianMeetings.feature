Feature: allow a guardian to see meetings

  Background: users have been added to to the tracker
    Given the following meetings have been added to the tracker:
      | student_id | nurse_id | start  | info |
      | 1 | 1 | 1999-12-12  |       Testing |
    Given an user has logged in with "steven@steel.com" and "12345"

  Scenario: See children meetings
    Given a guardian is on their schedule page
    Then a user should see a meeting schedule with "David" on "1999/12/12"

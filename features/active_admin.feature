Feature: Admin user can log in to admin pages
  As Gigafood
  In order to be able to maintain my business data
  I would like to be able to access the application through an admin interface

  Background:
    Given an admin user "admin@example.com" exists
    When I go to the dashboard

  Scenario: Logging in Successfully
    When I fill in "Email" with "admin@example.com"
    And I fill in "Password" with "password"
    And I press "Login"
    Then I should see "Signed in successfully."

  Scenario: Attempting to log in with an incorrect email address
    When I fill in "Email" with "not-an-admin@example.com"
    And I fill in "Password" with "not-my-password"
    And I press "Login"
    Then I should see "Login"
    And I should see "Invalid Email or password."

  Scenario: Attempting to log in with an incorrect password
    When I fill in "Email" with "admin@example.com"
    And I fill in "Password" with "not-my-password"
    And I press "Login"
    Then I should see "Login"
    And I should see "Invalid Email or password."
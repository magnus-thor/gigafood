Feature: List dishes on landing page
  As a end user
  In order to make a selection of dishes
  I would like to view dishes on a webpage

  Scenario: View a list of dishes on the screen
    When I go to the "landing" page
    Then I should see "Dish 1"
    Then I should see "Dish description for dish 1"
    Then I should see "100 SEK"

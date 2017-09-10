@javascript
Feature: Allow end user to select dishes and quantities to order.
  As an end-user
  In order to start my order
  I would like to be able to select a quantity of each dish I would like to order.

  Background:
    Given the following dishes exist:
      | name         | description             | price | min_quantity |
      | Dish 1       | Description for Dish 1  | 100   |  10          |
      | Dish 2       | Description for Dish 2  | 200   |  20          |
      | Dish 3       | Description for Dish 3  | 300   |  1           |

  Scenario: User can manipulate quantity with + and - buttons
    When I go to the landing page
    And I click on + for "Dish 1"
    And I click on + for "Dish 2"
    And I click on + for "Dish 3"
    Then "Dish 1" quantity should be "10"
    And "Dish 2" quantity should be "20"
    And "Dish 3" quantity should be "1"

    Scenario: The page should have a Next button to continue with order
      When I go to the landing page
      Then I should see the button "Next"

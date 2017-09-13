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
    And I click on + for "Dish 2"
    And I click on "Next"
    Then I should see "Dish 1"
    And I should see "1000"
    And I should see "Dish 2"
    And I should see "4200"
    And I should not see "Dish 3"
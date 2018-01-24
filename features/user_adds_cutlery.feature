Feature: User wants cutlery
  As a user
  In order to have the option to buy cutlery
  I need to be able to add cutlery to my order.

  Background:
    Given the following categories exist:
      | name    | description                |
      | Starter | Description for category 1 |
      | Main    | Description for category 2 |
      | Dessert | Description for category 3 |

    And the following dishes exist:
      | name    | description            | price | min_quantity | of_type |
      | Dish 1  | Description for Dish 1 | 100   | 10           | dish    |
      | Dish 2  | Description for Dish 2 | 200   | 10           | dish    |
      | Dish 3  | Description for Dish 3 | 300   | 10           | dish    |
      | Cutlery | Knife, fork and spoon  | 2     | 1            | cutlery |
    Then I go to the landing page
    And I click on + for "Dish 1"
    Then I click on "Next"

  Scenario: User adds/removes cutlery
    Given I select "cutlery" and fill in quantity with "5"
    When I press "Add"
    Then I should see "Cutlery Added"
    When I press "Remove"
    Then I should see "Cutlery Removed"

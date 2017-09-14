Feature: List dishes on landing page
  As a end user
  In order to make a selection of dishes
  I would like to view dishes on a webpage

  Background:
    Given the following categories exist:
      | name    | description                | sort_key |
      | Main    | Description for category 2 | 2        |
      | Starter | Description for category 1 | 1        |

    And the following dishes exist:
      | name   | description            | price | min_quantity | category |
      | Dish 1 | Description for Dish 1 | 100   | 10           | Starter  |
      | Dish 2 | Description for Dish 2 | 200   | 10           | Main     |
      | Dish 3 | Description for Dish 3 | 300   | 20           | Main     |

  Scenario Outline: View a list of dishes on the screen
    When I go to the landing page
    Then I should see "MAIN"
    Then I should see "STARTER"
    Then I should see "Minimum order: 20"
    Then I should see "<name>"
    Then I should see "<description>"
    Then I should see "<price>"

    Examples:
      | name         | description             | price | min_quantity |
      | Dish 1       | Description for Dish 1  | 100   |  10          |
      | Dish 2       | Description for Dish 2  | 200   |  10          |
      | Dish 3       | Description for Dish 3  | 300   |  10          |

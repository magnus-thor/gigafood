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
      | name   | description            | price | min_quantity | category | sort_key |
      | Start  | Description for Dish 1 | 100   | 10           | Starter  | 1        |
      | Corn   | Description for Dish 2 | 200   | 10           | Main     | 2        |
      | Tomato | Description for Dish 3 | 300   | 20           | Main     | 1        |

  Scenario Outline: View a list of dishes on the screen
    When I go to the landing page
    Then I should see "MAIN"
    Then I should see "STARTER"
    Then I should see "<name>"
    Then I should see "<description>"
    Then I should see "<price>"
    Then I should see "Minimum order of <min_quantity> portions."

    Examples:
      | name   | description            | price | min_quantity |
      | Start  | Description for Dish 1 | 100   | 20           |
      | Corn   | Description for Dish 2 | 200   | 10           |
      | Tomato | Description for Dish 3 | 300   | 10           |

  Scenario:
    When I go to the landing page
    Then Starter should be displayed before Main
    And Tomato should be displayed before Corn


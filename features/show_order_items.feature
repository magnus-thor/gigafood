Feature: Show order items in order
  As GigaFood
  In order to edit the order
  I need to see a list of dishes in the order

Background:
  Given an admin exists with email "admin@example.com" and password "password"
  And I'm logged in as admin

  Given the following categories exist:
    | name           | description                 |
    | Starter        | Description for category 1  |
    | Main           | Description for category 2  |
    | Dessert        | Description for category 3  |

  And the following dishes exist:
    | name         | description             | price | min_quantity |
    | Dish 1       | Description for Dish 1  | 100   |  10          |
    | Dish 2       | Description for Dish 2  | 200   |  10          |
    | Dish 3       | Description for Dish 3  | 300   |  10          |

  And the following orders exist:
    | billing_name  | delivery_date    | billing_email          |
    | Bob Schmob    | 2017-11-20 12:00 | bob.schmob@example.com |

  And the following orders items exist in the order:
    | dish    | quantity   |
    | Dish 1  | 13         |
    | Dish 2  | 14         |
    | Dish 3  | 15         |
  And I go to the dashboard

Scenario: View dishes on order
  When I press "Orders"
  And I press "View" for order "Bob Schmob"
  Then I should see "Dish 1"
  And I should see "13"
  And I should see "Dish 2"
  And I should see "14"
  And I should see "Dish 3"
  And I should see "15"

Scenario: Delete dishes from order
  When I press "Orders"
  And I press "View" for order "Bob Schmob"
  And I click Delete for "Dish 2"
  Then I should see "Order item was successfully destroyed."

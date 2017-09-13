Feature: Admin creates invoice
  As GigaFood
  In order to get payment for the order
  I need to generate a PDF invoice with order details and payment information


  Background:
    Given an admin exists with email "admin@example.com" and password "password"
    And I'm loged in as admin user "admin@example.com"
    Given I go to the dashboard

    And the following categories exist:
      | name    | description                |
      | Starter | Description for category 1 |

    And the following dishes exist:
      | name   | description            | price | min_quantity | category |
      | Dish 1 | Description for Dish 1 | 100   | 10           | Starter  |
      | Dish 2 | Description for Dish 2 | 200   | 10           | Starter  |
      | Dish 3 | Description for Dish 3 | 300   | 10           | Starter  |

    And the following orders exist:
      | billing_name | delivery_date    | billing_email          |
      | Bob Schmob   | 2017-11-20 12:00 | bob.schmob@example.com |
      | John Smith   | 2017-10-10 12:00 | john.smith@example.com |

    And "Bob Schmob"'s order contains:
      | dish_name | quantity |
      | Dish 1    | 10       |
      | Dish 2    | 20       |


    Scenario: Admin generates an invoice


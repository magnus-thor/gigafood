@javascript
Feature: List orders
  As Giga-Food
  In order update customers order
  I like to have be able to add dishes to the order

  Background:
    Given an admin exists with email "admin@example.com" and password "password"
    And I'm logged in as admin
    And I go to the dashboard
    And the following categories exist:
      | name    | description                |
      | Starter | Description for category 1 |
      | Main    | Description for category 2 |
      | Dessert | Description for category 3 |

    And the following dishes exist:
      | name   | description            | price | min_quantity |
      | Dish 1 | Description for Dish 1 | 100   | 10           |
      | Dish 2 | Description for Dish 2 | 200   | 10           |
      | Dish 3 | Description for Dish 3 | 300   | 10           |
    And the following orders exist:
      | billing_name | delivery_date    | billing_email          |
      | Bob Schmob   | 2017-11-20 12:00 | bob.schmob@example.com |
      | John Smith   | 2017-10-10 12:00 | john.smith@example.com |
      | Kari Lee     | 2017-10-08 12:00 | kari.lee@example.com   |


  Scenario: Add dishes to order
    When I press "Orders"
    And I press "Edit" for order "Bob Schmob"
    And I press "Add Dishes"
    And I click on + for "Dish 1"
    And I click on + for "Dish 2"
    And I click on + for "Dish 2"
    When I press "Update Order"
    Then I should see "Order was successfully updated"


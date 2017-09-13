Feature: As GigaFood
  In order to present the menu to the customer
  We need to add a category to each dish

Background:
  Given an admin exists with email "admin@example.com" and password "password"
  And I'm loged in as admin user "admin@example.com"
  Given I go to the dashboard
  And the following categories exist:
    | name           | description                 |
    | Starter        | Description for category 1  |
    | Main           | Description for category 2  |
    | Dessert        | Description for category 3  |
  And the following dishes exist:
    | name         | description             | price | min_quantity |
    | Dish 1       | Description for Dish 1  | 100   |  10          |
    | Dish 2       | Description for Dish 2  | 200   |  20          |
    | Dish 3       | Description for Dish 3  | 300   |  1           |


    Scenario: Add category to dish
      When I press "Dishes"
      When I press "New Dish"
      And I fill in "Name" with "Dish 4"
      And I fill in "Description" with "Description for Dish 4"
      And I fill in "Price" with "400"
      And I fill in "Min quantity" with "10"
      And I select "Starter" from "Category"
      And I press "Create Dish"
      Then I should see "Dish was successfully created."

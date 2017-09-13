Feature: As gigafood, create, destroy and update dishes
  As GigaFood
  In order to maintain a menu
  We need to be able to create, update and delete dishes (CRUD-functionality)

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
      | Dish 2       | Description for Dish 2  | 200   |  10          |
      | Dish 3       | Description for Dish 3  | 300   |  10          |

  Scenario: Add a new dish
    When I press "Dishes"
    When I press "New Dish"
    And I fill in "Name" with "Dish 4"
    And I fill in "Description" with "Description for Dish 4"
    And I fill in "Price" with "400"
    And I fill in "Min quantity" with "10"
    And I select "Starter" from "Category"
    And I press "Create Dish"
    Then I should see "Dish was successfully created."

  Scenario: Update dish
    When I press "Dishes"
    And I press "Edit" for dish "Dish 2"
    And I fill in "Description" with "Description for Dish 2"
    And I fill in "Price" with "404"
    And I fill in "Min quantity" with "5"
    #And I select "Starter" from "Category"
    And I press "Update Dish"
    Then I should see "Dish was successfully updated."

  Scenario: Delete dish
    When I press "Dishes"
    And I press "Delete" for dish "Dish 3"
    Then I should see "Dish was successfully destroyed."

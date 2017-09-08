Feature: As gigafood, create, destroy and update dishes
  As GigaFood
  In order to maintain a menu
  We need to be able to create, update and delete dishes (CRUD-functionality)

  Background:
    Given an admin exists with email "admin@example.com" and password "password"
    And I'm loged in as admin user "admin@example.com"
    Given I go to the dashboard
    And the following dishes exist:
      | name         | description             | price |
      | Dish 1       | Description for Dish 1  | 100   |
      | Dish 2       | Description for Dish 2  | 200   |
      | Dish 3       | Description for Dish 3  | 300   |

  Scenario: Add a new dish
    When I press "Dishes"

    When I press "New Dish"
    And I fill in "Name" with "Dish 4"
    And I fill in "Description" with "Description for Dish 4"
    And I fill in "Price" with "400"
    And I press "Create Dish"
    Then I should see "Dish was successfully created."

  Scenario: Update dish
    When I press "Dishes"
    And I press "view" on "Dish 1"
    And I fill in "Dish description" with "New description for Dish 4"
    And I fill in "Dish price" with "404"
    And I press "Save"
    Then I should see "Dish 4 successfully updated."

  Scenario: Delete dish
    When I press "Dishes"
    And I press "delete" on "Dish 2"
    And I press "Save"
    Then I should see "Dish 4 successfully deleted."

Feature: As gigafood, create, destroy and update dishes
  As GigaFood
  In order to maintain a menu
  We need to be able to create, update and delete dishes (CRUD-functionality)

  Background:
    Given an admin exists with email "admin@example.com" and password "password"
    And I'm loged in as admin user "admin@example.com"
    Given I go to the dashboard
    And I can see the following dishes:
      | name         | description             | price |
      | Dish 1       | Description for Dish 1  | 100   |
      | Dish 2       | Description for Dish 2  | 200   |
      | Dish 3       | Description for Dish 3  | 300   |

Scenario: Update dish
  When I press "Dishes"
  And show me the page
  And I press "View"
  And I fill in "Description" with "Description for Dish 1"
  And I fill in "Price" with "404"
  And I press "Save"
  Then I should see "Dish 4 successfully updated."

Feature: Admin adds custom translations
  As a Gigafood
  In order to have the customer to notice order details on servings
  We need to change or remove specs about minimum number of serving

  Background:

    Given the following dishes exist:
      | name    | description            | price | min_quantity | of_type |
      | Dish 1  | Description for Dish 1 | 100   | 10           | dish    |
      | Cutlery | Knife, fork and spoon  | 2     | 1            | cutlery |

    And there are no custom translations

    And an admin exists with email "admin@example.com" and password "password"
    And I'm logged in as admin
    And I go to the dashboard

  Scenario: Admin updates minimum order message
    Given I click on menu item "Translations"
    And I press "New Translation"
    And I select "menu.dish_min_quantity" from "Key"
    And I fill in "Value" with "Minimum order for this dish is %{min_count} portions."
    And I press "Create Translation"
    And I go to the landing page
    Then I should see "Minimum order for this dish is 10 portions."


  Scenario: Admin updates customer confirmation text
    Given skip this scenario
    Given I click on menu item "Translations"
    And I press "New Translation"
    And I select "confirm.main_header" from "Key"
    And I fill in "Value" with "Awesome dude!"
    And I press "Create Translation"
    And I click on menu item "Translations"
    And I press "New Translation"
    And I select "confirm.message_body" from "Key"
    And I fill in "Value" with "We will take a look and get back to you"
    And I press "Create Translation"
    And I go to the landing page
    And I click on + for "Dish 1"
    And I click on "Next"
    And I fill in all relevant fields and submit the order
    Then I should see "Awesome dude!"
    Then I should see "We will take a look and get back to you"



Feature: Admin generates a menu for a specific order
  As Gigafood
  In order to display and print the menu for the customer
  We need to be able to print the order menu.


  Background:
    Given the following categories exist:
      | name     | description              |
      | Starters | Description for starters |
      | Mains    | Description for mains... |

    And the following dishes exist:
      | name      | description            | price | min_quantity | category |
      | Starter   | Description for Dish 1 | 100   | 10           | Starters |
      | Main dish | Description for Dish 2 | 200   | 10           | Mains    |

    And the following orders exist:
      | billing_name | delivery_date    | billing_email          |
      | Bob Schmob   | 2017-11-20 12:00 | bob.schmob@example.com |

    Given "Bob Schmob"'s order contains:
      | dish_name | quantity |
      | Starter   | 10       |
      | Main dish | 20       |

    And an admin exists with email "admin@example.com" and password "password"
    And I'm loged in as admin user "admin@example.com"
    And I go to the dashboard
    And I click on "Orders"
    And I press "View" for order "Bob Schmob"

  Scenario: Admin generates order specific menu
    Given I press "Generate Menu"
    Then a menu for the order should be created
    Then I should not see "Generate Menu"
    And the pdf should contain "Starters"
    And the pdf should contain "Mains"
    And the pdf should contain "Starter"
    And the pdf should contain "Main dish"

  Scenario: Admin can't click on View Invoice if the invoice has not been generated
    Then I should not see "View Menu"

  @javascript
  Scenario: Admin views order
    Given an Menu has been generated for "Bob Schmob"'s order
    And I press "View Menu"
    Then I should see a pdf in a new window


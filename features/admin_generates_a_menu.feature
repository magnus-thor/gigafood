Feature: Admin generates a menu for a specific order
  As Gigafood
  In order to display and print the menu for the customer
  We need to be able to print the order menu.


  Background:
    Given the following categories exist:
      | name     | description                  | sort_key |
      | Starters | Description for starters     | 1        |
      | Mains    | Description for dessertss... | 2        |
      | Desserts | Description for dessertss... | 3        |

    And the following dishes exist:
      | name                 | description                                                                                                                                                                                                                                                                                                                            | price | min_quantity | category |
      | Starter dish         | Really really long description for this dish explaining how awesome it tastes and looks. We need this multi line description to test what happends if the table is overlaping the footer.                                                                                                                                              | 100   | 10           | Starters |
      | Another Starter dish | Really really long description for this dish explaining how awesome it tastes and looks. We need this multi line description to test what happends if the table is overlaping the footer.                                                                                                                                              | 100   | 10           | Starters |
      | Dessert dish         | Our dessert dish is simply fucking awespme                                                                                                                                                                                                                                                                                             | 200   | 10           | Desserts |
      | Main dish            | Our main dish is simply fucking awesome. It would take a really really long description for this dish explaining how awesome it actually is                                                                                                                                                                                            | 200   | 10           | Mains    |
      | Another Main dish    | Our main dish is simply fucking awesome. It would take a really really long description for this dish explaining how awesome it actually is. Really really long description for this dish explaining how awesome it tastes and looks. We need this multi line description to test what happends if the table is overlaping the footer. | 200   | 10           | Mains    |

    And the following orders exist:
      | billing_name | delivery_date    | billing_email          |
      | Bob Schmob   | 2017-11-20 12:00 | bob.schmob@example.com |

    Given "Bob Schmob"'s order contains:
      | dish_name            | quantity |
      | Starter dish         | 10       |
      | Another Starter dish | 10       |
      | Dessert dish         | 20       |
      | Main dish            | 20       |
      | Another Main dish    | 20       |

    And an admin exists with email "admin2@example.com" and password "password"
    And I'm logged in as admin
    And I go to the dashboard
    And I click on "Orders"
    And I press "View" for order "Bob Schmob"

  Scenario: Admin generates order specific menu
    Given I press "Generate Menu"
    Then a menu for the order should be created
    Then I should not see "Generate Menu"
    And the pdf should contain "Starter dish"
    And the pdf should contain "Another Starter dish"
    And the pdf should contain "Main dish"
    And the pdf should contain "Another Main dish"

  Scenario: Admin can't click on View Invoice if the invoice has not been generated
    Then I should not see "View Menu"

  @javascript
  Scenario: Admin views order
    Given an Menu has been generated for "Bob Schmob"'s order
    And I press "View Menu"
    Then I should see a pdf in a new window


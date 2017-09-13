@javascript
Feature: Allow end user to commit order
  As an end-user
  In order to complete my order
  I need to submit the order.

  Background:
    Given the following dishes exist:
      | name         | description             | price | min_quantity |
      | Dish 1       | Description for Dish 1  | 100   |  10          |

  Scenario: User can manipulate quantity with + and - buttons
    When I go to the landing page
    And I click on + for "Dish 1"
    And I click on "Next"
    And I fill in Delivery Date with "2017-11-10"

    And I fill in "Delivery Name" with "Hungry corp Inc"
    And I fill in "Delivery Address" with "Street 42"
    And I fill in "Delivery Postal Code" with "123 45"
    And I fill in "Delivery City" with "Town"
    And I fill in "Delivery Floor" with "3"
    And I fill in "Delivery Door Code" with "1111"
    And I fill in "Delivery Contact Name" with "John Doe"
    And I fill in "Delivery Contact Phone" with "555 123 45 67"
    And I fill in "Billing Name" with "John Doe"
    And I fill in "Billing Company" with "Hungry corp Inc"
    And I fill in "Billing Organisation Number" with "19210713-1444"
    And I fill in "Billing Address" with "Street 42"
    And I fill in "Billing Postal Code" with "123 45"
    And I fill in "Billing City" with "Town"
    And I fill in "Billing Contact Phone" with "555 123 55 11"
    And I fill in "Billing email" with "invoice@hungrycorp.com"
    And I click on "Submit Order"
    Then I should see "Thanks!"

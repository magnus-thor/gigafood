Feature: Allow end user to commit order
  As an end-user
  In order to complete my order
  I need to submit the order.

  Background:
    Given the following dishes exist:
      | name    | description            | price | min_quantity | of_type |
      | Dish 1  | Description for Dish 1 | 100   | 10           | dish    |
      | Dish 2  | Description for Dish 2 | 49    | 10           | dish    |
      | Dish 3  | Description for Dish 3 | 89    | 10           | dish    |
      | Cutlery | Knife, fork and spoon  | 2     | 1            | cutlery |
    And there are no custom translations

  Scenario: User get an error if Billing address is missing.
    When I go to the landing page
    And I fill in "Dish 1" with "10" to buy 10 dishes
    And I click on "Next"
    And I fill in Delivery Date with "2017-11-10 12:00"
    And I fill in "Delivery Name" with "Hungry corp Inc"
    And I fill in "Delivery Address" with "Street 42"
    And I fill in "Delivery_Postal_Code" with "123 45"
    And I fill in "Delivery City" with "Town"
    And I fill in "Delivery Floor" with "3"
    And I fill in "Delivery Door Code" with "1111"
    And I fill in "Delivery Contact Name" with "John Doe"
    And I fill in "Delivery Contact Phone" with "555 123 45 67"
    And I fill in "Billing Name" with "John Doe"
    And I fill in "Billing Company" with "Hungry corp Inc"
    And I fill in "Billing Organisation Number" with "19210713-1444"
    And I fill in "Billing_Postal_Code" with "123 45"
    And I fill in "Billing City" with "Town"
    And I fill in "Billing Contact Phone" with "555 123 55 11"
    And I fill in "Billing email" with "invoice@hungrycorp.com"
    And I click on "Submit Order"
    Then I should see "Error when saving order!"

  @javascript
  Scenario: User can manipulate quantity with + and - buttons
    Given skip this scenario
    When I go to the landing page
    And I click on + for "Dish 1"
    And I click on + for "Dish 2"
    And I click on + for "Dish 3"
    And I click on "Next"
    And I fill in Delivery Date with "2017-11-10 12:00"
    And I fill in "Delivery Name" with "Hungry corp Inc"
    And I fill in "Delivery Address" with "Street 42"
    And I fill in "Delivery_Postal_Code" with "123 45"
    And I fill in "Delivery City" with "Town"
    And I fill in "Delivery Floor" with "3"
    And I fill in "Delivery Door Code" with "1111"
    And I fill in "Delivery Contact Name" with "John Doe"
    And I fill in "Delivery Contact Phone" with "555 123 45 67"
    And I fill in "Billing Name" with "John Doe"
    And I fill in "Billing Company" with "Hungry corp Inc"
    And I fill in "Billing Organisation Number" with "19210713-1444"
    And I fill in "Billing Address" with "Street 42"
    And I fill in "Billing_Postal_Code" with "123 45"
    And I fill in "Billing City" with "Town"
    And I fill in "Billing Contact Phone" with "555 123 55 11"
    And I fill in "Billing email" with "invoice@hungrycorp.com"
    And I click on "Submit Order"
    Then I should see "Thanks for ordering from Gigafood!"
    And I should see "A confirmation email will be sent to you as soon as your booking is confirmed. Please contact us if you have any questions. We’d love to hear from you!"
    And the tax for the order should be "285.6"
    And the total for the order should be "2665.6"
    And the order should have delivery method set to "delivery"
    When I go to the landing page
    And I click on "Next"
    Then I should not see "Dish 1"
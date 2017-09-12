@javascript
Feature: Allow end user to select dishes and quantities to order.
  As an end-user
  In order to start my order
  I would like to be able to select a quantity of each dish I would like to order.

  Background:
    Given the following dishes exist:
      | name         | description             | price | min_quantity |
      | Dish 1       | Description for Dish 1  | 100   |  10          |

  Scenario: User can manipulate quantity with + and - buttons
    When I go to the landing page
    And I click on + for "Dish 1"
    And I click on "Next"
    And I should see input with id "delivery_date"
    And I should see input with id "delivery_time"
    And I should see input with id "delivery_name"
    And I should see input with id "delivery_address"
    And I should see input with id "delivery_postal_code"
    And I should see input with id "delivery_city"
    And I should see input with id "delivery_floor"
    And I should see input with id "delivery_door_code"
    And I should see input with id "delivery_contact_name"
    And I should see input with id "delivery_phone_number"
    And I should see input with id "invoice_name"
    And I should see input with id "invoice_company"
    And I should see input with id "invoice_org_nr"
    And I should see input with id "invoice_address"
    And I should see input with id "invoice_postal_code"
    And I should see input with id "invoice_city"
    And I should see input with id "invoice_phone"
    And I should see input with id "invoice_email"

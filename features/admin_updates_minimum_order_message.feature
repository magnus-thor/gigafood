Feature: Admin updates minimum order message
  As a Gigafood
  In order to have the customer to notice order details on servings
  We need to change or remove specs about minimum number of serving

  Background:
    Given an admin exists with email "admin@example.com" and password "password"
    And I'm loged in as admin user "admin@example.com"
    And I go to the dashboard

    Scenario: Admin updates minimum order message
      Given I click on "Translations"
      And I press "New Translation"
      And I select "minimum_order_form" from "Key"
      And I fill in "Value" with "You can order whatever amount you want"
      And I press "Create Translation"
      And I go to the landing page
      Then I should see "You can order whatever amount you want"



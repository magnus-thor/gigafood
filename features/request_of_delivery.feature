Feature: Request of transportation mail
  As GigaFood
  In order to book a delivery
  We need to generate a mail with transportation details when the order has been approved by Gigafood.

  Background:
    Given an admin exists with email "admin@example.com" and password "password"
    And I'm logged in as admin
    And I go to the dashboard
    And the following orders exist:
      | billing_name | created_at       | delivery_date    | email                  |
      | Bob Schmob   | 2017-11-15 10:00 | 2017-11-20 12:00 | bob.schmob@example.com |
      | John Smith   | 2017-10-05 11:00 | 2017-10-10 12:00 | john.smith@example.com |
      | Kari Lee     | 2017-10-03 14:00 | 2017-10-08 12:00 | kari.lee@example.com   |

  Scenario: Send request mail to delivery company
    When I click on "Orders"
    And I press "Edit" for order "Bob Schmob"
    And I fill in "order_boxes" with "15"
    And I click on "Update"
    Then I should see "Order was successfully updated"
    When I click on "Confirm Order"
    Then "boka@movebybike.se" should receive an email
    And "boka@movebybike.se" should see "Request for delivery from Gigafood" in the subject
    And "boka@movebybike.se" should see "Thanks!" in the email
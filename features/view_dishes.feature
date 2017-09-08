Feature: List dishes on landing page
  As a end user
  In order to make a selection of dishes
  I would like to view dishes on a webpage

  Scenario: View a list of dishes on the screen
    When I go to the landing page
    Then I should see "Rainbow Salad"
    Then I should see "Luxurious playful salad with loads of colorful greens. Served with green hummus, creamy cashew-dill-sauce, fennel, avocado, polka beat and nut n’ seed-sprinkle."
    Then I should see "107 SEK"

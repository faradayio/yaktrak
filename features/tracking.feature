Feature: Tracking
  In order to experience Brighter Planet's shipping emitter
  a user
  wants to track a package and get CO2 data
  
  Scenario: Tracking a package
    Given I am on the home page
    And I fill in "tracking_package_identifier" with "382544330058603"
    And I press "Track"
    Then I should see "CO2"
  
  Scenario: Invalid tracking number
    Given I am on the home page
    And I fill in "tracking_package_identifier" with "9101174929331000015592"
    And I press "Track"
    Then I should not see "CO2"

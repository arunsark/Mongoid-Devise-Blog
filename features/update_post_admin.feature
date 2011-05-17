Feature: Update/Destroy a Post as admin
  As an admin
  I want to Update or Destroy any post in the system

  Background: Logged in as Admin
    Given I am logged in as a "admin" with name "Arun"
         
  Scenario: Admin should have privilege to Update/Destroy any Post
    Given I have post "Foo Post" authored by "Suresh"
    When I visit Posts Page
    Then I should see the post
    And I should have the link to "Edit" or "Destroy"

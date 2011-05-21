
Feature: Create a Post
  As a registered user
  I want to Create a Post in the Blog
  So that Post appears in the Blog for others to consume
  
  Background: 
    Given I am logged in as a "author" with name "Arun"
  
  Scenario: Create a Post 
    Given I visit Create Post Page
    And I fill up Title as "Foo Post"
    And I fill up Content as "Bar Contents for Foo Post"
    And I publish the Post
    Then I should see message "Post was successfully created."
    And I should see post in the index page

  

  
      



Feature: Create a Post
  As a registered user
  I want to Create a Post in the Blog
  So that Post appears in the Blog for others to consume


  Scenario: Create a Post 
    Given I am an "author" with name "Arun", email "arun.vydianathan@gmail.com" and password "foobar"
    And I sign in as "arun.vydianathan@gmail.com/foobar"
    When I visit Create Post Page
    And I fill up Title as "Foo Post"
    And I fill up Content as "Bar Contents for Foo Post"
    And I publish the Post
    Then I should see message "Post was successfully created."
    And I should see post in the index page

  

  
      


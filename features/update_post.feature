

Feature: Update/Destroy a Post
  As an author of a Post
  I want to Update or Destroy the post created by me

  Background: Logged in as an author
    Given I am logged in as a "author" with name "Arun"
  
  Scenario: Update a Post
    Given I have post "Foo Post" authored by "Arun"
    When I visit Update Post Page
    And I fill up the Title as "Foo Bar Post"
    And I update the Post
    Then I should see message "Post was successfully updated."
    And I should see the updated title in the page
  
  Scenario: Delete a Post
    Given I have post "Foo Post" authored by "Arun"
    When I delete the post
    Then I should not see the post in the index page
  
  Scenario: Should not allow Update/Destroy of Post not written by Author
    Given I have post "Foo Post" authored by "Suresh"
    When I visit Posts Page
    Then I should see the post
    And I should not have the link to "Edit" or "Destroy"


 

  

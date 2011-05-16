

Feature: Update/Destroy a Post
  As an author of a Post
  I want to Update or Destroy the post created by me


  Scenario: Update a Post
    Given I am an "author" with name "Arun", email "arun.vydianathan@gmail.com" and password "foobar"
    And I sign in as "arun.vydianathan@gmail.com/foobar"
    And I have post "Foo Post" authored by me
    When I visit Update Post Page
    And I fill up the Title as "Foo Bar Post"
    And I update the Post
    Then I should see message "Post was successfully updated."
    And I should see post in the index page

  
  Scenario: Delete a Post
    Given I am an "author" with name "Arun", email "arun.vydianathan@gmail.com" and password "foobar"
    And I sign in as "arun.vydianathan@gmail.com/foobar"
    And I have post "Foo Post" authored by me
    When I delete the post
    Then I should not see the post in the index page


  Scenario: Should not allow Update/Destroy of Post not written by Author
    Given I am an "author" with name "Arun", email "arun.vydianathan@gmail.com" and password "foobar"
    And I sign in as "arun.vydianathan@gmail.com/foobar"
    And I have post "Foo Post" authored by "Suresh"
    When I visit Posts Page
    Then I should see the post
    And I should not have the link to "Edit" or "Destroy"

  
  Scenario: Admin should have privilege to Update/Destroy any Post
    Given I am an "admin" with name "Arun", email "arun.vydianathan@gmail.com" and password "foobar"
    And I sign in as "arun.vydianathan@gmail.com/foobar"
    And I have post "Foo Post" authored by "Suresh"
    When I visit Posts Page
    Then I should see the post
    And I should have the link to "Edit" or "Destroy"

  

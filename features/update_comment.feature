


Feature: Update/Destroy a Comment
  As an admin
  I should be allowed Update or Destroy any comment in the system

  Background: logged in as admin
    Given I am logged in as a "admin" with name "Arun"

  
  Scenario: Delete a Comment
    Given a blog post with title "Foo Post" and content "Bar Content"
    When I visit the Blog Post
    And I have a comment "Crappy Post"
    When I visit the Show Post Page
    Then I should see the Comment appearing in the Post
    And I should see a "Delete Comment" for the comment
    When I click the "Delete Comment" Link
    Then I should see the message "Comment deleted."
    And I should not see the Comment appearing in the Post

  Scenario: Update a Comment
    Given a blog post with title "Foo Post" and content "Bar Content"
    When I visit the Blog Post
    And I have a comment "Crappy Post"
    When I visit the Show Post Page
    Then I should see the Comment appearing in the Post
    And I should see a "Edit Comment" for the comment
    When I click the "Edit Comment" Link
    And I fill up the Content as "Its not so crappy"
    And I click the "Update Comment" Button
    Then I should see the message "Comment updated."
    And I should see the updated Comment appearing in the Post


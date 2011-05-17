
Feature: Create comment
  As a reader of the blog
  I want to Open a Post in the Blog
  And I should be able to fill in my comments for the post
  So that my Comments for the Post appears in the Blog

  
  Scenario: Create a Comment
    Given a blog post with title "Foo Post" and content "Bar Content"
    When I visit the Blog Post
    And I fill up Author as "Arun"
    And I fill up Email as "arun.vydianathan@gmail.com"
    And I fill up the Content as "Excellent Post"
    And I submit the Comment
    Then I should see message "Thanks for the comment"
    And I should see the Comment appearing in the Post


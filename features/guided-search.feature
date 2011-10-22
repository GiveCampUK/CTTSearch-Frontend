Feature: Guided search
  In order to gain insight into the areas of technology that I can benefit from
  As a charity
  I want to have an assisted search that highlights key areas of IT that is relevant to the size
  of my organisation and my technical competency.
  
@wip
Scenario Outline: can view nominated categories on the home page
  Given I am on the home page
  Then I should see "<category>"
  And I should see "<blurb>"
Scenarios:
  | category | blurb              |
  | Email    | How to setup email |
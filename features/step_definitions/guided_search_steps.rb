Given /^I am on the home page$/ do
  visit "/"
end

Then /^I should see "([^"]*)"$/ do |text|
  response_body.should contain text
end
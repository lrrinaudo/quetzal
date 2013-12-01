Feature: Suggestion
As a author
I want to see a candidate author

Background:
	Given I am current author

Scenario: Suggestion
	When I am writing a summary
	Then I should see "Proximo Autor"
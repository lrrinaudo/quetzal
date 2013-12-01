Feature: Long summary
As a author student
I want to write long summaries

Scenario: Create a new long summary
	Given I am current author
	And I am on new summary page
	When I fill fecha with "2013-11-11"
	And I fill num_clase with "23"
	And I fill ausentes with "Juanito"
	And I fill descripcion with long text
	And I push the button "Crear"
	Then I should see "Creacion de Resumen Exitoso y Mail enviado"
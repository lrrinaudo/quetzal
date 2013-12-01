Feature: Student's summaries
As a teacher
I want to see a list of students with their number of summaries

Scenario: List of students
	When I am on Students page
	Then I should see "Nombre"
	And I should see "Apellido"
	And I should see "Email"
	And I should see "Cantidad de Resumenes"
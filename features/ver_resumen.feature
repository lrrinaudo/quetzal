Feature: Ver resumen
  quiero ver los resumenes creados

  Background:
   	Given hay un resumen creado

  Scenario: ver resumen estando logeado
    Given que estoy logeado 
	And tengo acceso a la pagina de listado de resumenes
    When hago click en ver resumen
	Then deberia ver el resumen correctamente

  Scenario: ver resumen sin estar logeado
    Given tengo acceso a la pagina de listado de resumenes
	When hago click en ver resumen
    Then deberia ver el resumen correctamente

  

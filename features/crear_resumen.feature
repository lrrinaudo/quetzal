Feature: Resumen Texto
  In order de cumplir con la tarea
  As a alumno
  I want publicar mi resumen

  Background:
          Given Estoy dado de alta como alumno

  Scenario: Crear Resumen Texto
    Given Que acceda a la pagina de crear resumen texto
    When Yo lleno la fecha con "2013-09-10"
	And lleno Numero de clase con "20"
	And lleno Ausentes con "Juanito, Luisito"
	And lleno la Descripcion con "Bla bla bla"
        And confirmo el nuevo resumen con el boton crear  
    Then Yo deberia ver "Resumen Creado"

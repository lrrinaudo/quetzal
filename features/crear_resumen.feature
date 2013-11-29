Feature: Resumen Texto
  In order de cumplir con la tarea
  As a alumno
  I want publicar mi resumen

  Background:
        Given que estoy logeado  
   
  Scenario: Lista de resumenes
    Given que estoy en la pagina de lista de resumenes
    Then ver las columnas de los resumenes

  Scenario: Recibir mail 
    Given Que acceda a la pagina de Crear resumen
    When Yo creo un resumen
   	 And confirmo el nuevo resumen con el boton crear
    Then deberia recibir un mail con informacion del resumen
    	And con informacion del proximo alumno en subir resumen

   


Feature: Alta Alumno
  In order de tener mejor control de la clase
  As a docente
  I want dar de alta mis alumnos


  Scenario: Dar de Alta Alumno
    Given Que acceda a la pagina de Alta Alumno
    When Yo lleno Nombre con "Luisito"
	  And lleno Apellido con "Perez"
	  And lleno Email con "Luisito@gmail.com"
	  And lleno Confirmar Email con "Luisito@gmail.com"
	  And lleno Contrasena con "Passw0rd!"
	  And lleno Confirmar Contrasena con "Passw0rd!"
    And confirmo la nueva Alta de Alumno con el boton crear 

    

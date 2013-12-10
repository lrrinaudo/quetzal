Given(/^hay un resumen creado$/) do
  #Borrando posibles resumenes creados en otros escenarios
  Resumen.all.destroy
  
  #variebles
  @descripcion="En la clase se hablo de ..."
  @fecha="2013-11-23"
  @num_clase="4"
  @ausentes="Jose"
  @creador=Alumno.find_by_email("docente@unq.com")

  resumen=Resumen.new
  resumen.fecha=@fecha
  resumen.num_clase= @num_clase
  resumen.descripcion=@descripcion
  resumen.ausentes=@ausentes
  resumen.owner= @creador
  resumen.save
end

Given(/^tengo acceso a la pagina de listado de resumenes$/) do
  visit '/resumenes/latest'
end

When(/^hago click en ver resumen$/) do
  click_link('Ver')
end

Then(/^deberia ver el resumen correctamente$/) do
  page.should have_content(@descripcion)
  page.should have_content(@fecha)
  page.should have_content(@num_clase)
  page.should have_content(@ausentes)
  page.should have_content(@creador.nombre + " " + @creador.apellido)
end


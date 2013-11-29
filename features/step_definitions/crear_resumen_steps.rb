Given(/^Que acceda a la pagina de Crear resumen$/) do
  visit '/crear_resumen'
end

When(/^Yo creo un resumen$/) do
  fill_in('resumen[fecha]', :with => '2013-11-11')
  fill_in('resumen[num_clase]', :with => '23')
  fill_in('resumen[ausentes]', :with => 'Fulanito')
  fill_in('resumen[prox_autor]', :with => 'Lalolandia')
  descripcion = 'En la clase se hablo de ...'
  fill_in('resumen[descripcion]', :with => descripcion)
end

When(/^Yo creo un resumen con texto largo$/) do
  fill_in('resumen[fecha]', :with => '2013-5-5')
  fill_in('resumen[num_clase]', :with => '1')
  fill_in('resumen[ausentes]', :with => 'lalo')
  descripcionLarga = ''
  for i in(0..60000)
    descripcionLarga += 'p'
  end
  fill_in('resumen[descripcion]', :with => descripcionLarga)
  fill_in('resumen[prox_autor]', :with => 'Lalolandia')
end


Then(/^confirmo el nuevo resumen con el boton crear$/) do
 click_button('Crear')
end

Then(/^deberia poder ver "(.*?)"$/) do |contenido|
  page.should have_content(contenido)
end


Given(/^que estoy logeado$/) do
  visit '/iniciar_sesion'
  fill_in('alumno[email]', :with => 'docente@unq.com')
  fill_in('alumno[contrasena]', :with => 'Admin0n!')
  click_button('Iniciar')
  page.should have_content('docente@unq.com')
end



Given(/^que estoy en la pagina de lista de resumenes$/) do
  visit "/latest"
end

Then(/^ver las columnas de los resumenes$/) do
    visit "/resumenes/latest"
     page.should have_content('Fecha')
     page.should have_content('Clase')
     page.should have_content('Autor')
     page.should have_content('Resumen')
end

Then(/^deberia recibir un mail con informacion del resumen$/) do
   archivo_mail = "#{Padrino.root}/tmp/emails" 
   file = File.open("#{archivo_mail}/docente@unq.com", "r") 
   content = file.read 
   content.include?('Autor').should be true 
   content.include?('Fecha').should equal true 
   content.include?('Clase').should be true 
   content.include?('Ausentes').should be true 
   content.include?('Descripcion').should be true
 end

Then(/^con informacion del proximo alumno en subir resumen$/) do
   archivo_mail = "#{Padrino.root}/tmp/emails" 
   file = File.open("#{archivo_mail}/docente@unq.com", "r") 
   content = file.read 
   content.include?('El proximo autor es').should be true  
end


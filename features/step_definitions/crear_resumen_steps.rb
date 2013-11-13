Given(/^Que acceda a la pagina de Crear resumen$/) do
  visit '/crear_resumen'
end

When(/^Yo creo un resumen$/) do
  fill_in('resumen[fecha]', :with => '2013-11-11')
  fill_in('resumen[num_clase]', :with => '23')
  fill_in('resumen[ausentes]', :with => 'Fulanito')
  @descripcion = 'En la clase se hablo de ...'
  fill_in('resumen[descripcion]', :with => @descripcion)
end

Then(/^confirmo el nuevo resumen con el boton crear$/) do
 click_button('Crear')
end

Given(/^que estoy en la pagina de lista de resumenes$/) do
  visit "/latest"
end

Then(/^ver las columnas de los resumenes$/) do
    visit "/resumenes/latest"
     page.should have_content('Fecha')
     page.should have_content('Clase')
     page.should have_content('Ausentes')
     page.should have_content('Resumen')
end




Given(/^I am current author$/) do
  visit '/iniciar_sesion'
  fill_in('alumno[email]', :with => 'alumno@gmail.com')
  fill_in('alumno[contrasena]', :with => 'Admin0n!')
  click_button('Iniciar')
  page.should have_content('alumno@gmail.com')
end

When(/^I fill fecha with "(.*?)"$/) do |value|
  fill_in('resumen[fecha]', :with => value)
end

When(/^I fill num_clase with "(.*?)"$/) do |value|
  fill_in('resumen[num_clase]', :with => value)
end

When(/^I fill ausentes with "(.*?)"$/) do |value|
  fill_in('resumen[ausentes]', :with => value)
end

When(/^I fill descripcion with long text$/) do
  descripcionLarga = ''
  for i in(0..60000)
    descripcionLarga += 'p'
  end
  fill_in('resumen[descripcion]', :with => descripcionLarga)
end

When(/^I push the button "(.*?)"$/) do |button|
  click_button(button, match: :first)
end

When(/^I am writing a summary$/) do
  visit '/crear_resumen'
end

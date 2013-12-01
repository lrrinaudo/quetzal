require File.expand_path(File.dirname(__FILE__) + "/../../config/boot")

require 'capybara/cucumber'
require 'rspec/expectations'

#require 'simplecov'
require 'simplecov'
SimpleCov.start do
  root(File.join(File.dirname(__FILE__), '..','..'))
  coverage_dir 'reports/coverage'
  add_filter '/spec/'
  add_filter '/features/'
  add_filter '/admin/'
  add_filter '/db/'
  add_filter '/config/'
  add_group "Models", "app/models"
  add_group "Controllers", "app/controllers"
  add_group "Helpers", "app/helpers"
end

DataMapper::Logger.new($stdout, :all)
DataMapper.auto_migrate!
alumno = Alumno.create(:email => 'docente@unq.com',
                   :nombre => 'Nico',
		               :apellido => 'Paez', 
                   :contrasena => "Admin0n!")

alumno = Alumno.create(
      :email => 'alumno@gmail.com',
      :nombre => 'Fulanito',
      :apellido => 'Detal', 
      :cant_resumenes => 0,
      :contrasena => "Admin0n!")

##
# You can handle all padrino applications using instead:
#   Padrino.application
#Capybara.default_driver = :selenium
Capybara.app = Resumenes::App.tap { |app|  }

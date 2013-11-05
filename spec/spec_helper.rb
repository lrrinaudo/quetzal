PADRINO_ENV = 'test' unless defined?(PADRINO_ENV)

require 'simplecov'
SimpleCov.start do
	root(File.join(File.dirname(__FILE__), '..'))
	coverage_dir 'reports/coverage'
	add_filter '/spec/'
  add_filter '/features/'
  add_filter '/admin/'
  add_filter '/db/'
  add_filter '/config/'
  add_group 'Models', 'app/models'
  add_group 'Controllers', 'app/controllers'
  add_group 'Helpers', 'app/helpers'
end

require File.expand_path(File.dirname(__FILE__) + '/../config/boot')

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
  DataMapper::Logger.new($stdout, :all)
  DataMapper.auto_migrate!
  docente = Alumno.create(:email => 'docente@unq.com',
                   :nombre => 'Docente', 
                   :contrasena => "Admin0n!")
end

def app
  Resumenes::App.tap { |app|  }
end

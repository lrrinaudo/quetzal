require 'spec_helper'

describe Alumno do

	describe 'model' do

		subject { @alumno = Alumno.new }

		it { should respond_to( :id) }
		it { should respond_to( :nombre ) }
		it { should respond_to( :apellido ) }
		it { should respond_to( :contrasena_encriptada) }
		it { should respond_to( :email ) }

	end

	describe 'valid?' do

	  let(:alumno) { Alumno.new }

	  it 'Deberia ser false cuando el nombre esta en blanco' do
		alumno.apellido = 'Lopez'
	  	alumno.email = 'jlpz@unq.com'
	  	alumno.contrasena = 'a_secure_passWord!'
	  	alumno.valid?.should be_false
	  end

	 it 'Deberia ser false cuando el apellido esta en blanco' do
		alumno.nombre = 'Juan'
	  	alumno.email = 'jlpz@unq.com'
	  	alumno.contrasena = 'a_secure_passWord!'
	  	alumno.valid?.should be_false
	  end


	  it 'Deberia ser false cuando el email no es valido' do
	  	alumno.nombre = 'Juan'
	  	alumno.email = 'jlpz@unq.com'
	  	alumno.contrasena = 'a_secure_passWord!'
	  	alumno.valid?.should be_false
	  end

	  it 'Deberia ser false cuando la contrasena esta en blanco' do
	  	alumno.nombre = 'Juan'
		alumno.apellido = 'Lopez'
	  	alumno.email = 'jlpz@unq.com'
	  	alumno.valid?.should be_false
	  end

	  it 'Deberia ser false cuando la contrasena no contiene un caracter en minuscula' do
	  	alumno.nombre = 'Juan'
		alumno.apellido = 'Lopez'
	  	alumno.email = 'jlpz@unq.com'
	  	alumno.contrasena = 'ABCDEFGH'
	  	alumno.valid?.should be_false
	  end

	  it 'Deberia ser false cuando la contrasena no contiene un caracter en mayuscula' do
	  	alumno.nombre = 'Juan'
		alumno.apellido = 'Lopez'
	  	alumno.email = 'jlpz@unq.com'
	  	alumno.contrasena = 'abcdefgh'
	  	alumno.valid?.should be_false
	  end

	  it 'Deberia ser false cuando la contrasena no contiene un digito' do
	  	alumno.nombre = 'Juan'
		alumno.apellido = 'Lopez'
	  	alumno.email = 'jlpz@unq.com'
	  	alumno.contrasena = 'SinDigitos'
	  	alumno.valid?.should be_false
	  end

	  it 'Deberia ser false cuando la contrasena es < 8' do
	  	alumno.nombre = 'Juan'
		alumno.apellido = 'Lopez'
	  	alumno.email = 'jlpz@unq.com'
	  	alumno.contrasena = 'Peq0'
	  	alumno.valid?.should be_false
	  end

	  it 'Deberia ser true cuando todos los campos son validos' do
	  	alumno.nombre = 'Juan'
		alumno.apellido = 'Lopez'
	  	alumno.email = 'jlpz@unq.com'
	  	alumno.contrasena = 'V4l1dP4ssw0rd'
	  	alumno.valid?.should be_true
	  end

	end

	describe 'autenticacion' do

		before do
			@contrasena = 'V4l1dP4ssw0rd'
		 	@alumno = Alumno.new
		 	@alumno.email = 'jlpz@unq.com'
		 	@alumno.contrasena = @contrasena
		end

		it 'Deberia retornar nil cuando la contrasena no coincide' do
			email = @alumno.email
			contrasena = 'contrasena_incorrecta'
			Alumno.should_receive(:find_by_email).with(email).and_return(@alumno)
			Alumno.autenticar(email, contrasena).should be_nil
		end

		it 'Deberia retornar nil cuando el email no coincide' do
			email = 'wrong@email.com'
			Alumno.should_receive(:find_by_email).with(email).and_return(nil)
			Alumno.autenticar(email, @contrasena).should be_nil
		end

		it 'Deberia retornar el alumno cuando el email y contrasena coinciden' do
			email = @alumno.email
			Alumno.should_receive(:find_by_email).with(email).and_return(@alumno)
			Alumno.autenticar(email, @contrasena).should eq @alumno
		end

	end

	describe 'sugerencia del proximo alumno en escribir un resumen' do

                before(:each) do
                        @arevalo=Alumno.new
			@arevalo.id=1
                        @arevalo.nombre="Alejandro"
                        @arevalo.apellido="Arevalo"
                        @arevalo.contrasena="Alumno1234"
			@arevalo.email="aarevalo@gmail.com"
			@arevalo.cant_resumenes=0
			@arevalo.save

                        @belgrano=Alumno.new
			@belgrano.id=2
                        @belgrano.nombre="Beatriz"
                        @belgrano.apellido="Belgrano"
                        @belgrano.contrasena="Alumno1234"
			@belgrano.email="bbelgrano@gmail.com"
			@belgrano.cant_resumenes=0
			@belgrano.save
 
			@ciruelo=Alumno.new
			@ciruelo.id=3
                        @ciruelo.nombre="Carlos"
                        @ciruelo.apellido="Ciruelo"
                        @ciruelo.contrasena="Alumno1234"
			@ciruelo.email="cciruelo@gmail.com"
			@ciruelo.cant_resumenes=0
			@ciruelo.save 

			#Por ahora no se guardan,solo en algunos test lo requieren
			@arevaloPedro=Alumno.new
			@arevaloPedro.id=4
		        @arevaloPedro.nombre="Pedro"
		        @arevaloPedro.apellido="Arevalo"
		        @arevaloPedro.contrasena="Alumno1234"
			@arevaloPedro.email="aarevalo@gmail.com"
			@arevaloPedro.cant_resumenes=0

			@alves=Alumno.new
			@alves.id=4
		        @alves.nombre="Pedro"
		        @alves.apellido="Alves"
		        @alves.contrasena="Alumno1234"
			@alves.email="aarevalo@gmail.com"
			@alves.cant_resumenes=0
			 
                
                  end

                after(:each) do
                            Alumno.all.destroy
                 end
        
                it 'deberia retornar al alumno Arevalo cuando nadie tene resumenes creados' do
      
                 Alumno.proximo_alumno().should == @arevalo
                end

		it 'deberia retornar al alumno Belgrano cuando Arevalo tiene un resumen' do
      		 @arevalo.cant_resumenes=1
		 @arevalo.save
                 Alumno.proximo_alumno().should == @belgrano
                end

		it 'deberia retornar al alumno Ciruelo cuando Arevalo y beatriz  tienen un resumen' do
      		 @arevalo.cant_resumenes=1
		 @arevalo.save
		 @belgrano.cant_resumenes=1
		 @belgrano.save
                 Alumno.proximo_alumno().should == @ciruelo
                end

		it 'deberia retornar al alumno Ciruelo cuando Arevalo tiene 2 resumenes y beatriz  tienen un resumen' do
      		 @arevalo.cant_resumenes=2
		 @arevalo.save
		 @belgrano.cant_resumenes=1
		 @belgrano.save
                 Alumno.proximo_alumno().should == @ciruelo
                end

		it 'deberia retornar nil cuando no hay alumnos registrados' do
      		 Alumno.all.destroy
                 Alumno.proximo_alumno().should == nil
                end

		it 'deberia retornar al alumno Arevalo cuando  todos tienen un resumen' do
      		 @arevalo.cant_resumenes=1
		 @arevalo.save
		 @belgrano.cant_resumenes=1
		 @belgrano.save
		 @ciruelo.cant_resumenes=1
		 @ciruelo.save
                 Alumno.proximo_alumno().should == @arevalo
                end

		it 'deberia retornar al alumno Ciruelo cuando Arevalo y Belgrano tienen 2 resumenes cada uno' do
      		 @arevalo.cant_resumenes=2
		 @arevalo.save
		 @belgrano.cant_resumenes=2
		 @belgrano.save
                 Alumno.proximo_alumno().should == @ciruelo
                end

		it 'deberia retornar al alumno Arevalo cuando Ciruelo tiene un resumen' do
		 @ciruelo.cant_resumenes=1
		 @ciruelo.save
                 Alumno.proximo_alumno().should == @arevalo
                end


		it 'deberia retornar al alumno Arevalo Alejandro cuando nadie tienen resumenes y existe el alumno Alves Pedro' do
		 #En este caso se tiene en cuanta el orden alfabetico por nombre
		 @arevaloPedro.save
                 Alumno.proximo_alumno().should == @arevalo
                end

		it 'deberia retornar al alumno Alves cuando nadie tienen resumenes y existe el alumno Arevalo' do
		 @alves.save
                 Alumno.proximo_alumno().should == @alves
                end
               
        end

end

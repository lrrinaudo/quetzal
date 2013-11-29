Resumenes::App.controllers :resumenes do


  get :index do
    @resumenes = Resumen.all
    render '/'
  end

  
  get :latest do
    @resumenes = Resumen.all
    render 'resumenes/lista'
  end

  get :nuevo, :map => '/crear_resumen' do
    @resumen = Resumen.new
    @alumnosOrdenados = Alumno.all(:order => [:cant_resumenes.asc, :apellido.asc, :nombre.asc])
     # @alumnosOrdenados.each do | i |
     #   puts '-------------------------'
     #   puts 'APELLIDO:'
     #   puts i.apellido
     #   puts 'NOMBRE'
     #   puts i.nombre
     #   puts 'CANTIDAD'
     #   puts i.cant_resumenes
     # end
     @proximoAlumno = @alumnosOrdenados.first
    render 'resumenes/nuevo'
  end

 get :ver do
    @resumen = Resumen.all
    render 'resumenes/ver'
  end

  post :crear do
        @resumen = Resumen.new(params[:resumen])
        @resumen.owner = alumno_actual
        if @resumen.save
          alumno_actual.cant_resumenes = alumno_actual.cant_resumenes + 1
          alumno_actual.save
          flash[:success] = 'Creacion de Resumen Exitoso y Mail enviado'
          @resumen.enviar_email(@resumen)
          redirect '/'
        else
          flash.now[:error] = 'Todos los campos son obligatorios'
          render 'resumenes/nuevo'
        end
  end

end

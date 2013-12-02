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
    @proximoAlumno=Alumno.proximo_alumno()
    render 'resumenes/nuevo'
  end

 get :ver, :with => :resumen_id  do
    @resumen = Resumen.get(params[:resumen_id])
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

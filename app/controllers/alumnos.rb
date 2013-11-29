Resumenes::App.controllers :alumnos do
  
  # get :index, :map => '/foo/bar' do
  #   session[:foo] = 'bar'
  #   render 'index'
  # end

  # get :sample, :map => '/sample/url', :provides => [:any, :js] do
  #   case content_type
  #     when :js then ...
  #     else ...
  # end

  # get :foo, :with => :id do
  #   'Maps to url '/foo/#{params[:id]}''
  # end

  # get '/example' do
  #   'Hello world!'
  # end

  get :nuevo, :map => '/alta_alumno' do
    @alumno = Alumno.new
    render 'alumnos/nuevo'
  end

  get :latest do
    @alumnos = Alumno.all
    render 'alumnos/lista'
  end

  post :crear do
      confirmar_email = params[:alumno][:confirmar_email]
      params[:alumno].reject!{|m,n| m == 'confirmar_email'}
      confirmar_contrasena = params[:alumno][:confirmar_contrasena]
      params[:alumno].reject!{|k,v| k == 'confirmar_contrasena'}
      if ((params[:alumno][:contrasena] == confirmar_contrasena) && (params[:alumno][:email] == confirmar_email))
        @alumno = Alumno.new(params[:alumno])
        @alumno.cant_resumenes = 0
        if @alumno.save
          flash[:success] = 'Alta de Alumno exitosa'
          redirect '/'
        else
          flash.now[:error] = 'Todos los campos son obligatorios'
          render 'alumnos/nuevo'
        end
      else
        @alumno = Alumno.new (params[:alumno])
        flash.now[:error] = 'No coincide la contrasena'
        render 'alumnos/nuevo'          
      end
  end

end

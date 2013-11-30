class Alumno 
  include DataMapper::Resource

  property :id, Serial
  property :nombre, String
  property :apellido, String
  property :contrasena_encriptada, String
  property :email, String
  property :cant_resumenes, Integer, :default => 0
  has n, :resumens

  validates_presence_of :nombre
  validates_presence_of :apellido
  validates_presence_of :contrasena_encriptada
  validates_presence_of :email
  validates_format_of   :email,    :with => :email_address
  validates_with_method :es_contrasena_segura?

  def es_contrasena_segura?
    true
  end

  def contrasena= (contrasena)
    if contrasena[/[[:lower:]]/] and contrasena[/[[:upper:]]/] and
       contrasena[/\d/] and (contrasena.length >= 8)
      self.contrasena_encriptada = ::BCrypt::Password.create(contrasena)
    end
  end

  def self.autenticar(email, contrasena)
    alumno = Alumno.find_by_email(email)
    return nil if alumno.nil?
    alumno.tiene_contrasena?(contrasena)? alumno : nil
  end

  def tiene_contrasena?(contrasena)
    ::BCrypt::Password.new(contrasena_encriptada) == contrasena
  end

  #proximo alumno en escribir un resumen
  def self.proximo_alumno()
    alumnosOrdenados = Alumno.all(:order => [:cant_resumenes.desc, :apellido.asc, :nombre.asc])
    cant_resumenes_maximo = alumnosOrdenados.first.cant_resumenes

    alumnosOrdenados.each do |alumno|
	if alumno.cant_resumenes != cant_resumenes_maximo then
		 return alumno
	end
    end
    alumnosOrdenados.first
  end

end

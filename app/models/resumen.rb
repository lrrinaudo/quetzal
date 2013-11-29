class Resumen 
  include DataMapper::Resource

  property :id, Serial
  property :fecha, String
  property :num_clase, String
  property :ausentes, String
  property :descripcion, Text  
  property :prox_autor, String
  belongs_to :alumno

  validates_presence_of :fecha
  validates_presence_of :num_clase
  validates_presence_of :ausentes
  validates_presence_of :descripcion
  
  def owner
    alumno
  end

  def owner=(un_alumno)
    self.alumno = un_alumno
  end

  def self.find_by_owner(alumno)
    Resumen.all(:alumno => alumno)
  end

  def enviar_email(resumen)
        alumnos = Alumno.all
        alumnos.each do | alumno |
          Resumenes::App.deliver(:notificacion, :info_email, resumen, alumno)
        end
  end
  
end

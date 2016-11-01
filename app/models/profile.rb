class Profile < ActiveRecord::Base
  #asociaciones
  has_many :advances
  has_many :skills, through: :advances #tiene muchas habilidades a través del modelo advances

  #permitir formularios anidados para que cuando cree o actualice un perfil  tambien puede agregar avances en habilidades
  #allow_destroy me permite eliminar registrps
  #reject_if: lambda  me permite rechazar o no agregar registros que vengan vacios
  accepts_nested_attributes_for :advances, allow_destroy: true,reject_if: lambda {|attributes| attributes['skill_id'].blank?}
end

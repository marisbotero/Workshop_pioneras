class Advance < ActiveRecord::Base
  #asociaciones
  belongs_to :profile #el registro de este modelo pertence a un perfil
  belongs_to :skill #pertence a una habilidad
end

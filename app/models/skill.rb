class Skill < ActiveRecord::Base
  #asociaciones
  has_many :advances
  has_many :profiles, through: :advances #tiene muchas perfiles a través del modelo advances
end

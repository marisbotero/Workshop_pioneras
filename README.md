# Workshop_pioneras

Despues de haber realizado la instalación, vamos a crear una nueva aplicación nombrada  *workshop_pioneras*

##Crear app
Abre la terminal y ubica la carpeta donde deseas guardar la app, para navegar entre carpetas en la terminal usamos los comandos ```$ cd nombredelacarpeta``` para entrar y ```$ cd ..``` para salir. Ademas con ```$ ls```  o ```$ dir``` puedes ver lo que hay dentro de la capeta en la que te encuentras.

Para crear la app de rails ejecutamos

```
$ rails new workshop_pioneras
```

```
$ cd workshop_pioneras
```
Ahora abre la carpeta foodie en tu editor de texto, revisemos algunas de las carpetas de la aplicación de rails

|Carpeta  | Propósito                                                                                            |
|---------|------------------------------------------------------------------------------------------------------|
| app/    | Contiene los modelos, controladores, vistas, estilos e imagenes, correos, helpers                    |
| config/ | Configuración de las rutas, base de datos, ambientes de desarrollo, traducciones y otros             |
| db/     | Contiene el esquema, las migraciones o cambios de la base de datos                                   |
| public/ | Archivos públicos como imagenes y paginas estaticas de errores de peticiones HTTP                    |
| vendor/ | Contiene los códigos de terceros (e.g. Bootstrap, plantillas )                                       |
| Gemfile/| Archivo con las Gemas de la aplicación, cada vez que se modifique ejecutamos ```$bundle install ```  |


##Welcome Page

Para la landing necesitamos como mínimo un controlador y una vista,Para generarlos ejecuta:
```
$rails generate controller  Welcome index
```
Esto crea un controlador llamado * Welcome* con una acción o método llamado *index*  y dentro de la carpeta de vistas una carpeta que se llama * Welcome* con un archivo ``` .html.erb```  llamado *index*  y su ruta de acceso en el archivo ``` routes.rb```

abre la vista que se encuenta en  ``` app/views/welcome/index.html.erb``` y empieza agregar información a la  Welcome page.

##Aplicación en el navegador
Levantemos el servidor de rails para empezar a ver la aplicación funcionando, Ejecuta:
```
$rails server
```
En tu navegador abre  [http://localhost:3000](http://localhost:3000)

En la terminal presiona <kbd>Ctrl</kbd>+<kbd>C</kbd> para detener el servidor

##ROOT (página de inicio)
configuremos la landing como pagina de inicio cuando abramos  [http://localhost:3000](http://localhost:3000).

Abre el archivo que se encuenta en  ``` config/routes.rb ```  y cambia la linea
```ruby
get 'Welcome/index'
```
por
```ruby
root 'Welcome#index'
```
##Scaffolding
El scaffolding es una técnica que permite crear CRUD(Create, Read, Update, Delete) de un model, pero en forma mucho más rápida. Abrimos nuestra consola y escribimos: 
```
$rails g scaffold Skill name:string
```
Hacer esto fue como crear un modelo, creará las migraciones y los atributos correspondientes al skill; el nombre Pero, lo interesante de esto es que también creará por nosotros un controlador llamado skills con las acciones: index, show, new, create, edit, update y destroy , junto con sus vistas. Osea ya tenemos todo listo para agregar, modificar, eliminar y listar-ver- nuestras habilidades(skills). Tambien nos crea assets(diseño).


Creamos de la misma manera los scaffolds para el perfil (puedes completar los campos con la bd que ya hemos estructurado):
```
$rails g scaffold Profile name:string
```
ahora creamos un modelo donde tendremos el progreso de nuestras habilidades(skills) a través del tiempo.
```
$rails g model Advance profile:references skill:references percentage:integer description:string
```
el tipo *references* nos hace la relación de que el modelo Advance pertenece a el modelo profile y tambien al modelo skill.

Cada vez que se crean migraciones, para poder visualizar la aplicación en el navegador rails nos pide que generemos esas migraciones en la BD con este comando:
```
$rake db:migrate
```
asi creamos las tablas en la BD

##  Relaciones en los modelos

> - Relaciones de uno a uno

Estas se dan cuando un registro está ligado a otro. Por ejemplo, nosotros podemos tener un modelo llamado Usuario y un modelo llamado Perfil. Cada usuario tendrá un perfi y este le pertenecerá a un usuario.

> - Relaciones de uno a muchos

Son las relaciones más comunes. En este caso un registro puede tener relación con otros, pero cada uno de esos otros le pertenecerán sólo a ese registro. Por ejemplo, siguiendo con el modelo Usuario y un modelo Publicacion, cada usuario puede tener varias publicaciones, pero cada publicación le pertenecerá a un usuario.

> - Relaciones de muchos a muchos

Estas relaciones se dan cuando un registro puede tener relaciones con otros registros, pero a su vez estos registros además de tener relación con el primero pueden estar vinculados con otros. Por ejemplo, suponiendo que seguimos con el modelo Usuario, nosotros queremos saber qué habilidades tiene a cada usuario, así que también tendremos un modelo habilidades. Entonces en ese caso cada a un usuario le pueden gustar varias habilidades, pero estas a su vez también las tendran otros usuarios.

Para nuestro taller los modelos con sus relaciones quedarian así:

en app/models/profile.rb copia
```Ruby
class Profile < ActiveRecord::Base
  #asociaciones
  has_many :advances
  has_many :skills, through: :advances #tiene muchas habilidades a través del modelo advances
end

```
en app/models/skill.rb
```Ruby
class Skill < ActiveRecord::Base
  #asociaciones
  has_many :advances
  has_many :profiles, through: :advances #tiene muchas perfiles a través del modelo advances
end
```
en app/models/advance.rb ya tenemos esto , puesto que el references lo genera:
```Ruby
class Advance < ActiveRecord::Base
  #asociaciones
  belongs_to :profile #el registro de este modelo pertence a un perfil
  belongs_to :skill #pertence a una habilidad
end
```
##  Recursos de rutas
Bueno, ahora que ya tenemos una idea de la unión de modelos vamos a seguir con nuestro proyecto, creando las funcionalidades de los modelos.Vamos dentro de nuestro proyecto a config -> routes.rb 

> - resource

Un resource o recurso es una colección predefinida de todas las posibles funciones que por defecto que posee un controlador. Es decir, cuando utilizamos un scaffold para crear un controlador, modelo y vistas relacionadas a un recurso tal como "usuario"; este creará dentro del controlador todas las funciones conocidas como CRUD, y el resource combina y genera todas las rutas necesarias para poder acceder a dichos recursos. 

en config/routes.rb
```Ruby
Rails.application.routes.draw do
  resources :skills
  resources :profiles
end
```
Ahora podemos abrir la consola y escribir el siguiente comando para visualizar la estructura de las rutas:
```
$rake routes
```

##Formulario del avance en habilidades anidado en el perfil

para permitir que mi modelo profile reciba atributos de mi modelo skill en app/models/profile.rb agregamos
```Ruby
  #permitir formularios anidados para que cuando cree o actualice un perfil  tambien puede agregar avances en habilidades
  #allow_destroy me permite eliminar registrps
  #reject_if: lambda  me permite rechazar o no agregar registros que vengan vacios
  accepts_nested_attributes_for :advances, allow_destroy: true,reject_if: lambda {|attributes| attributes['skill_id'].blank?}
```

para pintar el formulario anidado en app/views/profiles/\_form.html.erb   antes del 
```Html
<div class="actions">  
```
copiamos:
```html
Habilidades:
  <ul>
    <%= f.fields_for :advances do |advance_form| %>
     <li>
       <%= advance_form.check_box :_destroy%>

       <%= advance_form.label :skill_id  %>
       <%= advance_form.select :skill_id, Skill.all.collect { |habilidad| [ habilidad.name, habilidad.id ] }, include_blank: true  %>

       <%= advance_form.label :percentage  %>
       <%= advance_form.text_field :percentage %>

       <%= advance_form.label :description  %>
       <%= advance_form.text_field :description %>
     </li>
    <% end %>
  </ul>
  ```
 

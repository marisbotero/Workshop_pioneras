# Workshop_pioneras

Despues de haber realizado la instalación, vamos a crear una nueva aplicación nombrada  *Workshop_pioneras*

##Crear app
Abre la terminal y ubica la carpeta donde deseas guardar la app, para navegar entre carpetas en la terminal usamos los comandos ```$ cd nombredelacarpeta``` para entrar y ```$ cd ..``` para salir. Ademas con ```$ ls```  o ```$ dir``` puedes ver lo que hay dentro de la capeta en la que te encuentras.

Para crear la app de rails ejecutamos

```
$ Workshop Pioneras
```

```
$ cd Workshop_pioneras
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
El scaffolding es una técnica que permite crear CRUD, pero en forma mucho más rápida. Abrimos nuestra consola y escribimos: 
```
$rails g scaffold area name:string
```
Hacer esto fue como crear generar un modelo, creará las migraciones y los atributos correspondientes para al area, el nombre Pero, lo interesante de esto es que también creará por nosotros un controlador llamado areas con las acciones que venimos creando: index, show, new, create, edit, update y destroy. Osea ya tenemos todo listo para agregar, modificar, eliminar y nuestras areas.

Ahora debemos crear la tabla:
```
$rake db:migrate
```
Creamos de la misma maneras los scaffolds para el perfil y las habilidades:
```
$rails g scaffold profile name:string
```

```
$rails g scaffold skill profile_id:integer skill progress description:text area_id:integer
```
Creamos las tablas:
```
$rake db:migrate
```

##  Relaciones en los modelos

> - Relaciones de uno a uno

Estas se dan cuando un registro está ligado a otro. Por ejemplo, nosotros podemos tener un modelo llamado Usuario y un modelo llamado Perfil. Cada usuario tendrá un perfi y este le pertenecerá a un usuario.

> - Relaciones de uno a muchos

Son las relaciones más comunes. En este caso un registro puede tener relación con otros, pero cada uno de esos otros le pertenecerán sólo a ese registro. Por ejemplo, siguiendo con el modelo Usuario y un modelo Publicacion, cada usuario puede tener varias publicaciones, pero cada publicación le pertenecerá a un usuario.

> - Relaciones de muchos a muchos

Estas relaciones se dan cuando un registro puede tener relaciones con otros registros, pero a su vez estos registros además de tener relación con el primero pueden estar vinculados con otros. Por ejemplo, suponiendo que seguimos con el modelo Usuario, nosotros queremos saber qué habilidades tiene a cada usuario, así que también tendremos un modelo habilidades. Entonces en ese caso cada a un usuario le pueden gustar varias habilidades, pero estas a su vez también las tendran otros usuarios.

Para nuestro taller los modelos con sus relaciones quedarian así:

```
class Area < ActiveRecord::Base
  has_many :skills
  has_many :profiles, through: :skills
end

```

```
class Profile < ActiveRecord::Base
  has_many :skills
  has_many :areas, through: :skills
  accepts_nested_attributes_for :skills, allow_destroy: true,reject_if: lambda {|attributes| attributes['area_id'].blank?}
end

```
```
class Skill < ActiveRecord::Base
  belongs_to :profile
  belongs_to :area
end
```
##  Recursos de rutas
Bueno, ahora que ya tenemos una idea de la unión de modelos vamos a seguir con nuestro proyecto, creando las funcionalidades de los modelos.Vamos dentro de nuestro proyecto a config -> routes.rb 

> - resource

Un resource o recurso es una colección predefinida de todas las posibles funciones que por defecto que posee un controlador. Es decir, cuando utilizamos un scaffold para crear un controlador, modelo y vistas relacionadas a un recurso tal como "usuario"; este creará dentro del controlador todas las funciones conocidas como CRUD, y el resource combina y genera todas las rutas necesarias para poder acceder a dichos recursos. 

```
Rails.application.routes.draw do
  resources :areas
  resources :profiles
end
```
Ahora podemos abrir la consola y escribir el siguiente comando:
```
$rake routes
```

Las rutas se ven de la siguiente manera:

```
Prefix Verb   URI Pattern                  Controller#Action
       areas GET    /areas(.:format)             areas#index
             POST   /areas(.:format)             areas#create
    new_area GET    /areas/new(.:format)         areas#new
   edit_area GET    /areas/:id/edit(.:format)    areas#edit
        area GET    /areas/:id(.:format)         areas#show
             PATCH  /areas/:id(.:format)         areas#update
             PUT    /areas/:id(.:format)         areas#update
             DELETE /areas/:id(.:format)         areas#destroy
    profiles GET    /profiles(.:format)          profiles#index
             POST   /profiles(.:format)          profiles#create
 new_profile GET    /profiles/new(.:format)      profiles#new
edit_profile GET    /profiles/:id/edit(.:format) profiles#edit
     profile GET    /profiles/:id(.:format)      profiles#show
             PATCH  /profiles/:id(.:format)      profiles#update
             PUT    /profiles/:id(.:format)      profiles#update
             DELETE /profiles/:id(.:format)      profiles#destroy

```



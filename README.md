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
##

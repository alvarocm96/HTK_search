Los **requerimientos** para poder llevar a cabo las operaciones que se detallan en este documento son (elegir según formato de ejecución: docker o windows):
1. Para la ejecución mediante docker, es necesario tener descargado el mismo (más adelante se proporciona información para la instalación) y los archivos que se encuentran en este repositorio.
2. Para la ejecución en Windows, será necesario tener permisos de administrador, descargar los archivos de este repositorio y el zip de Solr, y tener instalada la PowerShell y  Java. En la segunda modalidad de este tutorial se profundiza sobre estos requerimientos.
3. Opcional: Python versión 3. 

# GUÍA DOCKER
## 1. Preparar entorno de trabajo
Para levantar correctamente el servicio de indexación de Solr primero se debe tener como se comenta en los requisitos de este modo de ejecución del proyecto, el programa Docker instalado correctamente. 

*// Si no se dispone del programa, en el siguiente link que lleva al tutorial de la página oficial se pueden encontrar varios link para la instalación según el sistema operativo de la máquina, y una guía de instalación y manejo de la herramienta realizada sobre un ejemplo:
https://docs.docker.com/get-started/*

Para poder indexar los datos se debe tener acceso a la información sobre la que se realizan las búsquedas, para ello clonando este proyecto, o descargando los archivos en un zip. Se debe descomprimir y en dicha carpeta descomprimida ejecutar los comandos que se indican en esta parte del tutorial. 

La carpeta contendrá diferentes archivos, pero solo es necesario el uso de “recouTest_tratado_2.csv”.

*// También se podría usar el script de Python y el archivo “recoutTest.mlf” para generar el archivo recoutTest_tratado_2.mlf y solamente sería necesario renombrar el archivo como csv (recoutTest_tratado_2.csv) para la indexación.*

## 2. Procedimiento para levantar Solr desde Docker
En primer lugar, hay que descargarse la imagen oficial de Solr que se encuentra en Docker Hub:
````
docker pull solr:8.8.2
````
*// Que descarga la versión 8.8.2 de la imagen oficial de doker hub de Solr.
Se podría comprobar si la imagen está correctamente descargada tanto desde la app docker desktop, como desde la línea de comandos con el comando : "docker images" .*

Para crear un contenedor de la imagen de Solr:
````
docker run -dp 8983:8983 --name solr_busqueda solr:8.8.2 solr-precreate htk_search
````

*// Ya se puede comprobar que Solr está escuchando en el puerto 8983 de la máquina anfitriona. http://localhost:8983/solr 
No haría falta realizar el docker pull, ya que al hacer el docker run y no encontrar la imagen, iría a buscarla al hub y haría la operación de pull automáticamente.*

## 3. Indexar información en Solr
Para el proceso de indexación se debe copiar el archivo que se va a usar para indexar los datos (hay que situarse en la carpeta que contiene el archivo .csv):

Para pasar los archivos locales al contenedor:
````
docker cp ./recoutTest_tratado_2.csv solr_busqueda:/opt/solr-8.8.2
````

Para indexar el csv en el core creado de Solr:
````
docker exec -it solr_busqueda post -c htk_search ./recoutTest_tratado_2.csv
````

## 4. Realizar búsquedas
En este punto la información ya está correctamente indexada y se pueden hacer búsquedas sobre la información.

- Mediante la UI de Solr: en este caso acceder a http://localhost:8983/solr/ y seleccionar el núcleo que se haya creado. Una vez se despliegan las diferentes opciones, escoger “Query”. En el nuevo espacio que aparece se pueden configurar diferentes parámetros, en este caso, para la realización de búsquedas bastaría con cambiar:

	- ‘q’: __palabra:ríos__ *//Este ejemplo serviría para buscar la palabra rios entre toda la información disponible. Para realizar cualquier búsqueda basta con añadir “palabra:----“ y añadir después de los dos puntos, la palabra deseada.*
	- ‘rows’: por defecto viene configurado con 10, pero se podría elegir un número mayor de visualizaciones. (se ha probado hasta 100.000).

*// A continuación se incluyen algunos ejemplos de las búsquedas que se pueden realizar de la información indexada:*

- *"palabra:rios": el resultado obtenido son 474 coincidencias de esta palabra clave sobre el conjunto de datos*
 
- *"palabra:Aneto": el resultado obtenido son 10 coincidencias de esta palabra clave sobre el conjunto de datos*

- *"palabra:Ebro": el resultado obtenido son 96 coincidencias de esta palabra clave sobre el conjunto de datos* 

- *"palabra:Cantabrico": el resultado obtenido son 66 coincidencias de esta palabra clave sobre el conjunto de datos*

- *"palabra:Asturias": el resultado obtenido son 30 coincidencias de esta palabra clave sobre el conjunto de datos*


__### WARNING  ### Se aconseja detener el contenedor cuando se haya finalizado el proceso de búsqueda para evitar el consumo de recursos de la máquina anfitriona.__

Para comprobar el id del contenedor solr_busqueda:
````
docker ps
````

Para parar la ejecución del contenedor, dos opciones, mediante el id,  o el nombre:
````
docker stop the-container-id
	
docker stop solr_busqueda
````

Para eliminar el contenedor de Solr:
````
docker rm the-container-id

docker rm solr_busqueda
````

Para eliminar la imagen de Solr, igual que antes, con el id o el nombre:
````
docker rmi solr:8.8.2

docker rmi the-image-id
````

## ----

# GUÍA WINDOWS

## 1. Preparar entorno de trabajo
Para la ejecución en Windows, será necesario en primer lugar tener permisos de administrador en el sistema, descargar los archivos que se proporcionan en este repositorio, tener la PowerShell versión 5.1 (por defecto a partir de windows 8.1), tener instalado java versión 8 o superior, y descargar el .zip de la versión 8.8.2 de Solr de su página oficial: https://solr.apache.org/downloads.html
Para levantar correctamente el servicio de indexación de Solr primero se debe habilitar la ejecución de scripts, que más tarde se recomendará volver a deshabilitar para evitar problemas de seguridad, ya que en caso de no habilitarlo se obtendría un mensaje de error. 
Para poder ejecutar los scripts que contiene el proyecto y ayudan con la creación de un servicio que luego usaremos para hacer consultas, se proveen varios scripts:
1. primer_script_levantar.ps1
2. segundo_script_recuperar.ps1
3. tercer_script_consulta.ps1

Para permitir la ejecución de estos scripts,  se debe seleccionar la directiva *RemoteSigned* o *Unrestricted* , ya que por defecto el sistema la establece como *Restricted*. Para ello se debe buscar la PowerShell y ejecutar como administrador. Una vez dentro, se debe ejecutar el siguiente comando para cambiar la directiva por defecto que se comenta con anterioridad:
````
Set-ExecutionPolicy RemoteSigned
````

En este punto ya se pueden lanzar los scripts *.ps1* contenidos en la carpeta del proyecto.

## 2. Levantar el servidor con Solr
El primer script que se debe lanzar para levantar un servicio de Solr en el ordenador, se llama *primer_script_levantar.ps1*.
Este script descomprime automáticamente el contenido de Solr, y ejecuta Solr en la línea de comandos para configurar el servicio. Para una correcta configuración, una vez se indique por pantalla que se ha entrado correctamente en el modo cloud, y para poder hacer uso de los scripts proporcionados se deben seguir los siguientes pasos:
*// los pasos indicados crearán una colección por defecto que luego se usa para indexar contenido y realizar consultas* 

- Enter para el número de nodos, 2 por defecto.
- Enter para el puerto del primer nodo, si queremos que esté en el 8983, que es el puerto designado por la IANA para Apache Solr.
- Enter para el puerto del segundo nodo, si queremos que esté en el 7574, que es el puerto designado por la IANA para “Oracle Coherence Cluster Service”, registrado en 2014-07-09. 
*// No habría problema en elegir puertos distintos para levantar el servidor con Solr, pero es necesaria la configuración por defecto indicada para poder hacer uso de los scripts.*
- Se debe dejar algo de tiempo a Solr para que levante los puertos.
- Se pide el nombre que se le va a dar a la colección (luego se comprueba en la UI de Solr como se crea correctamente). Se debe recordar el nombre asignado ya que luego será necesario para ejecutar las consultas con los scripts desde la línea de comandos. Ejemplo: __prueba_solr__
- Se pide el número de shards, enter para seleccionar el default, 2.
- Nos pide el número de réplicas, enter para seleccionar el default, 2.
- Nos pide la configuración que se quiere para el esquema, se debe introducir por pantalla la opción por defecto que nos indica: _default_ 

*// Tras breves instantes indicará que el proceso se ha completado, y que visitemos la dirección "http://localhost:8983/solr" en el buscador (eligiendo correctamente el puerto de acceso,en caso de que haya sido cambiado).*

__### WARNING  ### Una vez se haya terminado de usar es recomendable terminar su ejecución para liberar los puertos y detener el servicio, para ello, se debe ejecutar en la misma ubicación donde se levantan el servicio Solr, el siguiente comando:__ 
````
.\bin\solr.cmd stop -all
````

El sistema informará de que ambos nodos se han detenido correctamente.

## 3. Navegar por la UI de Solr
Si se ha decidido parar la ejecución como se comenta al final del punto 2, se deberá hacer uso del script *segundo_script_recuperar.ps1* para levantar de nuevo el servicio. Una vez levantado se podrá navegar por el UI de Solr como se comenta a continuación. 

Cuando se accede a la URL comentada en el punto anterior (http://localhost:8983/solr/#/), se puede comprobar cómo se ha creado el servicio según la configuración elegida. 

Dado el formato en el que se levanta este servicio de “cloud”, es posible acceder al mismo y comprobar los nodos levantados y más parámetros que detallan información relativa al servicio. 

Se pueden ver las colecciones creadas en el menú desplegable. (Ejemplo: __prueba_solr__ ) Si se selecciona la colección con el nombre elegido durante el proceso de configuración, aparecerá un menú que permitirá, entre otros, hacer indexación de documentos, lanzar querys, etc.

En puntos posteriores se explica cómo indexar información y cómo lanzar querys tanto manualmente, como haciendo uso de los scripts proporcionados. 

## 4. Indexar información
Para ello, partiendo del punto anterior donde se ha seleccionado la colección a utilizar, seleccionar la opción “Documents” que abrirá un panel en el que se pueden configurar varios parámetros. 

En este nuevo espacio, para indexar el contenido proporcionado, se debe cambiar, el “Document Type” y se debe seleccionar “csv”. En el apartado “Document(s) se debe copiar y pegar toda la información del fichero que queramos indexar en el sistema, en el formato proporcionado.  
*// Para que Solr entienda la información que se introduce en el sistema, y para facilitar la visualización de información y realización de búsquedas sobre la misma, se procede a un tratado de la información:*

- Si se tiene Python instalado, se puede hacer uso del script de Python, aunque se recomienda el uso del archivo final proporcionado en este repositorio. Para ello se debe simplemente ejecutar el script proporcionado “script_tratado_información.py”. (Dado que se proporciona dicho archivo, para comprobar su correcto funcionamiento, se recomienda borrar el .csv tratado proporcionado en este repositorio)

- En caso de no tener Python, hacer uso del archivo *recoutTest_tratado_2.mlf* que contiene la información ya tratada y lista para ser indexada. 

## 5. Realizar búsquedas
Para poder realizar búsquedas, una vez se tenga la información indexada, se puede hacer uso del script proporcionado, o usar la UI de Solr.

- Búsqueda mediante scripts: para ello se debe ejecutar el script *tercer_script_consulta.ps1* seguido de varios parámetros:

	- Param 1: para elegir el browser donde se quiere visualizar la información. Habría varias posibilidades: "msedge", "chrome", "firefox" .
	- Param 2: nombre de la colección que se ha creado durante el proceso de configuración al levantar el servicio de Solr. Ejemplo: __prueba_solr__.
	- Param 3: palabra que queremos buscar en el sistema. (Ejemplo: *rios*).

- Mediante la UI de Solr: en este caso acceder a http://localhost:8983/solr/ y seleccionar la colección que se haya creado. Una vez se despliegan las diferentes opciones, escoger “Query”. En el nuevo espacio que aparece se pueden configurar diferentes parámetros, en este caso, para la realización de búsquedas bastaría con cambiar:

	- ‘q’: __palabra:ríos__ *//Este ejemplo serviría para buscar la palabra rios entre toda la información disponible. Para realizar cualquier búsqueda basta con añadir “palabra:----“ y añadir después de los dos puntos, la palabra deseada.*
	- ‘rows’: por defecto viene configurado con 10, pero se podría elegir un número mayor de visualizaciones. (se ha probado hasta 100.000).

*// A continuación se incluyen algunos ejemplos de las búsquedas que se pueden realizar de la información indexada desde la línea de comandos:*

- *".\tercer_script_consulta.ps1 firefox prueba_solr rios": el resultado obtenido son 474 coincidencias de esta palabra clave sobre el conjunto de datos*

- *".\tercer_script_consulta.ps1 chrome prueba_solr Aneto": el resultado obtenido son 10 coincidencias de esta palabra clave sobre el conjunto de datos*

- *".\tercer_script_consulta.ps1 msedge prueba_solr Ebro": el resultado obtenido son 96 coincidencias de esta palabra clave sobre el conjunto de datos*

- *".\tercer_script_consulta.ps1 chrome prueba_solr Cantabrico": el resultado obtenido son 66 coincidencias de esta palabra clave sobre el conjunto de datos*

- *" .\tercer_script_consulta.ps1 chrome prueba_solr Asturias": el resultado obtenido son 30 coincidencias de esta palabra clave sobre el conjunto de datos*
	

Los requerimientos para poder llevar a cabo las operaciones que se detallan en este documento son (elegir una según el SO utilizado):
-	Para le ejecución en Windows, será necesario en primer lugar tener permisos de administrador en el sistema, descargar la carpeta "windows" que se provee en el repositorio de GitHub y tener instalado java versión 8 o superior.
-	Programa “Docker…”
-	Opcional: Python versión 3. 

# GUÍA WINDOWS

# 1.	Preparar entorno de trabajo
Para levantar correctamente el servicio de indexación de Solr primero se debe habilitar la ejecución de scripts, que más tarde se recomendará volver a deshabilitar para evitar problemas de seguridad, ya que en caso de no habilitarlo se obtendría un mensaje de error. 
Para poder ejecutar los scripts que contiene el proyecto y ayudan con la creación de un servicio que luego usaremos para hacer consultas, se proveen varios scripts:
- primer_script_levantar.ps1
- segundo_script_recuperar.ps1
- tercer_script_consulta.ps1

Para permitir la ejecución de estos scripts,  se debe seleccionar la directiva "RemoteSigned" , ya que por defecto el sistema la establece como “Restricted”. Para ello se debe buscar la PowerShell y ejecutar como administrador. Una vez dentro, se debe ejecutar el siguiente comando para cambiar la directiva por defecto que se comenta con anterioridad:
Set-ExecutionPolicy RemoteSigned

En este punto ya se pueden lanzar los scripts .ps1 contenidos en la carpeta del proyecto.

# 2.	Levantar el servidor con Solr
El primer script que se debe lanzar para levantar un servicio de Solr en el ordenador, se llama "primer_script_levantar.ps1".
Este script descomprime automáticamente el contenido de Solr, y ejecuta Solr en la línea de comandos para configurar el servicio. Para una correcta configuración, una vez se indique por pantalla que se ha entrado correctamente en el modo cloud, y para poder hacer uso de los scripts proporcionados se deben seguir los siguientes pasos:
los pasos indicados crearán una colección por defecto que luego se usa para indexar contenido y realizar consultas.
* Enter para el número de nodos, 2 por defecto.
* Enter para el puerto del primer nodo, si queremos que esté en el 8983, que es el puerto designado por la IANA para Apache Solr.
-- Enter para el puerto del segundo nodo, si queremos que esté en el 7574, que es el puerto designado por la IANA para “Oracle Coherence Cluster Service”, registrado en 2014-07-09. 
// no habría problema en elegir puertos distintos para levantar el servidor con Solr, pero es necesaria la configuración por defecto indicada para poder hacer uso de los scripts.
* Se debe dejar algo de tiempo a Solr para que levante los puertos.
* Se pide el nombre que se le va a dar a la colección (luego se comprueba en la UI de Solr como se crea correctamente). Se debe recordar el nombre asignado ya que luego será necesario para ejecutar las consultas con los scripts desde la línea de comandos. Ejemplo: prueba_solr
* Se pide el número de shards, enter para seleccionar el default, 2.
* Nos pide el número de réplicas, enter para seleccionar el default, 2.
* Nos pide la configuración que se quiere para el esquema, se debe introducir por pantalla la opción por defecto que nos indica: _default 

// Tras breves instantes indicará que el proceso se ha completado, y que visitemos la dirección "http://localhost:8983/solr" en el buscador eligiendo correctamente el puerto de acceso en caso de que haya sido cambiado. 

# ### WARNING  ### Una vez se haya terminado de usar es recomendable terminar su ejecución para liberar los puertos y detener el servicio, para ello, se debe ejecutar en la misma ubicación donde se levantan el servicio Solr, el siguiente comando: 
.\bin\solr.cmd stop -all

El sistema informará de que ambos nodos se han detenido correctamente.

# 3.	Navegar por la UI de Solr
Si se ha decidido parar la ejecución como se comenta al final del punto 2, se deberá hacer uso del script “segundo_script_recuperar.ps1” para levantar de nuevo el servicio. Una vez levantado se podrá navegar por el UI de Solr como se comenta a continuación. 

Cuando se accede a la URL comentada en el punto anterior (http://localhost:8983/solr/#/), se puede comprobar cómo se ha creado el servicio según la configuración elegida. 

Dado el formato en el que se levanta este servicio de “cloud”, es posible acceder al mismo y comprobar los nodos levantados y más parámetros que detallan información relativa al servicio. 

Se pueden ver las colecciones creadas en el menú desplegable. (Ejemplo: prueba_solr ) Si se selecciona la colección con el nombre elegido durante el proceso de configuración, aparecerá un menú que permitirá, entre otros, hacer indexación de documentos, lanzar querys, etc.

En puntos posteriores se explica cómo indexar información y cómo lanzar querys manualmente, y haciendo uso de los scripts proporcionados. 

# 4.	Indexar información
Para ello, partiendo del punto anterior donde se ha seleccionado la colección a utilizar, seleccionar la opción “Documents” que abrirá un panel en el que se pueden configurar varios parámetros. 

En este nuevo espacio, para indexar el contenido proporcionado, se debe cambiar, el “Document Type” y se debe seleccionar “csv”. En el apartado “Document(s) se debe copiar y pegar toda la información del fichero que queramos indexar en el sistema, en el formato proporcionado.  
// Para que Solr entienda la información que se introduce en el sistema, y para facilitar la visualización de información y realización de búsquedas sobre la misma, se procede a un tratado de la información:

I.	Si se tiene Python instalado, haciendo uso del script de Python. Para ello se debe simplemente ejecutar el script proporcionado “script_tratado_información.py”.

II.	En caso de no tener Python, hacer uso del archivo “recoutTest_tratado_2.mlf” que contiene la información ya tratada y lista para ser indexada. 

# 5.	Realizar búsquedas
Para poder realizar búsquedas, una vez se tenga la información indexada, se puede hacer uso del script proporcionado, o usar la UI de Solr.

I. Búsqueda mediante scripts: para ello se debe ejecutar el script “tercer_script_consulta.ps1” seguido de varios parámetros:
	a. Param 1: para elegir el browser donde se quiere visualizar la información. Habría varias posibilidades: msedge, chrome, firefox .
	b. Param 2: nombre de la colección que se ha creado durante el proceso de configuración al levantar el servicio de Solr. Ejemplo: prueba_solr.
	c. Param 3: palabra que queremos buscar en el sistema. (Ejemplo: rios).

II. Mediante la UI de Solr: en este caso acceder a http://localhost:8983/solr/ y seleccionar la colección que se haya creado. Una vez se despliegan las diferentes opciones, escoger “Query”. En el nuevo espacio que aparece se pueden configurar diferentes parámetros, en este caso, para la realización de búsquedas bastaría con cambiar:
	a. ‘q’: palabra:ríos #Este ejemplo serviría para buscar la palabra rios entre toda la información disponible. Para realizar cualquier búsqueda basta con añadir “palabra:----“ y añadir después de los dos puntos, la palabra deseada. 
	b. ‘rows’: por defecto viene configurado con 10, pero se podría elegir un número mayor de visualizaciones. (se ha probado hasta 100.000).



## README: informar al usuario de que tiene que introducir las siguientes cosas por pantalla:
## -> enter para el número de nodos = 2
## -> enter para el puerto del primer nodo, si queremos que esté en el 8983, en otro caso determinar dicho puerto
## -> enter para el puerto del segundo nodo, si queremos que esté en el 7574, en otro caso se debe determinar dichu puerto
## OJO luego al lanzar los comandos para levantar los nodos de Solr en el 'primer_script_prueba.ps1',
## podría especificar que se mandasen por pantalla, y si no se rellenan dejar que los default sean los 8983 y los 7574
##
## -> De debe dejar algo de tiempo a Solr para que levtante los puertos.
## -> Se pide el  nombre que se le va a dar a la colección (luego se cmprueba en la UI de Solr como se crea correctamente)
## -> Nos pide el numero de shards, enter para seleccionar el default, 2.
## -> Nos pide el numero de replicas, enter para seleccionar el default, 2.
## -> Nos pide la configuración que se quiere para el esquema, se debe teclear la opción por defecto que nos indica: _default
## -> Tras breves instantes indicará que el proceso se ha completado, y que visitemos la dirección "http://localhost:8983/solr" en el buscador
## eligiendo correctamente el puerto de acceso en caso de que haya sido cambiado. 
##
##
## WARNING: Una vez se haya terminado de usar es recomendable terminar su ejecución para liberar los puertos y detener el servicio, para ello, 
## se debe ejecutar en la misma ubicación donde se levantan el servicio Solr, el siguiente comando: 
## .\bin\solr.cmd stop -all
## El sistema nos informará de que ambos nodos se han detenido correctamente.

Expand-Archive -LiteralPath .\solr-8.8.2.zip 
$str = "cd ./solr-8.8.2"
$str2 = "./bin/solr.cmd start -e cloud"
Invoke-Expression $str
Invoke-Expression $str2

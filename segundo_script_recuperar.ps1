
# parar los puertos por si el usuario no los ha parado antes!
$str_01 = ".\solr-8.8.2\bin\solr.cmd stop -all"

$route_02 = Get-Location



#levantar los nodos
$str_02 = ".\solr-8.8.2\bin\solr start -c -p 8983 -s .\solr-8.8.2\example\cloud\node1\solr"
$str_03 = ".\solr-8.8.2\bin\solr.cmd start -cloud -p 7574 -s " + "'" + $route_02 + "\solr-8.8.2\example\cloud\node2\solr' -z localhost:9983"

#$str_04 = "Start-Process chrome 'http://localhost:8983/solr/'"

Invoke-Expression $str_01
Invoke-Expression $str_02
Invoke-Expression $str_03
#Invoke-Expression $str_04


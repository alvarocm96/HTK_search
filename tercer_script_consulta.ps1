

## levantar chrome: Start-Process chrome "http://localhost:8983/solr/prueba01/select?q=palabra%3" + "" +&rows=100"
## levantar en firecox: Start-Process firefox "http://localhost:8983/solr/prueba01/select?q=palabra%3" + "" +&rows=100"
## levantar en edge: Start-Process msedge "http://localhost:8983/solr/prueba01/select?q=palabra%3" + "" +&rows=100"

$str_04 = "Start-Process " + $args[0] + " 'http://localhost:8983/solr/" + $args[1] + "/select?q=palabra%3A" + $args[2] + "+&rows=100'"

Invoke-Expression $str_04


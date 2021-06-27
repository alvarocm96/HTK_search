
Expand-Archive -LiteralPath .\solr-8.8.2.zip 
$str = "cd ./solr-8.8.2"
$str2 = "./bin/solr.cmd start -e cloud"
Invoke-Expression $str
Invoke-Expression $str2

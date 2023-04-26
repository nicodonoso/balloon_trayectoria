#!/bin/sh

# V0 funciona pero es necesario editar algunos path donde estará el script. 
# Hay que cambiar donde dice : /home/nico/bash_script/balloon_predict/
# También editar latitud (lat) y longitud(lon) del lugar de lanzamiento

# Por Nicolás Donoso ->  nicolasdonosocastro@gmail.com
# Este script corre el pronóstico de trayectoria de http://predict.habhub.org
# y genera como resultado un KML con la trayectoria que se puede abrir desde google earth.
# La idea es que se puede ejecutar desde el crontab en forma automática para mantener un registro de los pronósticos. 
# Se ejecuta ./run_balloont.sh 

# ----------------------------------------------------------------------------
# "LA LICENCIA BEER-WARE" (Versión 42):
# Nico Donoso escribió este script. Siempre y cuando usted mantenga este aviso,
# puede hacer lo que quiera con este programa. Si nos encontramos algún día, y usted piensa
# que esto vale la pena, me puede comprar una cerveza a cambio. Nico
# ----------------------------------------------------------------------------


# obtenemos por script el kml del pronóstico de http://predict.habhub.org
## Obtenemos la fecha de hoy
year=$(date +"%Y")
month=$(date +"%m")
day=$(date +"%d")
#hora UTC
hour=$(date -u +"%H")
min_ac=$(date +"%M")
min=$(($min_ac))
#por seguridad se corre en 5 min mdespués
#sec=$(date +"%S")

# Obtenemos la ruta al archivo
CWD=$(pwd)
echo El script se corre en $CWD


echo Se corre para el tiempo:
echo ${year}/${month}/${day} ${hour}:${min}
echo ###############################################################

## Lat, Lon y altura
lat=-45.5790
#lon=-71.61
lon=287.9300 #Esta corresponde a una longitud de -72.07
h=40 # altura de lanzamiento
## Ballon [m/s],[m]
vel_up=5
vel_down=2
ruptura=30000 #[m]
#drag=

echo Corremos curl para obtener uuid del pronóstico
echo Corremos para la siguiente URL 
echo '\n'
echo 'https://api.v2.sondehub.org/tawhiri?profile=standard_profile&pred_type=single&launch_datetime='"${year}"
curl 'https://api.v2.sondehub.org/tawhiri?profile=standard_profile&pred_type=single&launch_datetime='"${year}"'-'"${month}"'-'"${day}"'T'"${hour}"'%3A02%3A00Z&launch_latitude='"${lat}"'&launch_longitude='"${lon}"'&launch_altitude=0&ascent_rate='"${vel_up}"'&burst_altitude='"${ruptura}"'&descent_rate='"${vel_down}"'&format=kml' -o $CWD/Cambridge_nuevo_${year}${month}${day}${hour}${min}.kml #/home/nico/Documentos/Familia/globos/balloon_trayectoria/script_salida.kml #$CWD/Cambridge_nuevo_${year}${month}${day}${hour}${min}.kml
# ejemplo de url es https://api.v2.sondehub.org/tawhiri?profile=standard_profile&pred_type=single&launch_datetime=2023-04-26T17%3A02%3A00Z&launch_latitude=-55.6597&launch_longitude=287.0000&launch_altitude=0&ascent_rate=5&burst_altitude=30000&descent_rate=5&format=kml


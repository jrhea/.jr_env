if [ $1 -ne 1 ]
then
  curl http://192.168.1.56:8080/tv/tune?major=$1
fi
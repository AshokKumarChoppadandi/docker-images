echo "Testing the Installation by running PI MAPREDUCE EXAMPLE"
docker exec -u hadoop -it nodemaster yarn jar hadoop-2.7.7/share/hadoop/mapreduce/hadoop-mapreduce-examples-2.7.7.jar pi 10 10

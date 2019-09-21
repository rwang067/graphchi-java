# #!/bin/bash

# # mvn assembly:assembly -DdescriptorId=jar-with-dependencies

echo "2019.7.29 " >> drunkardmob.statistics
echo "time cost breakdown comparison (clear pagecache each time) in 64GB R730, dataset = Yahoo" >> drunkardmob.statistics
echo "Turn on Page Cache, clear pagecache each time, nshards = 25" >> drunkardmob.statistics

### 64GB R730, SSD, Yahoo
################################################################################################
echo "App = RandomWalkDomination" >> drunkardmob.statistics
for(( times = 0; times < 5; times++))
do
    echo "times = " $times " from echo"
    free -m
    sync; echo 1 > /proc/sys/vm/drop_caches
    free -m
    java -Xmx40960m -cp target/graphchi-java-0.2.2-jar-with-dependencies.jar edu.cmu.graphchi.apps.randomwalks.RandomWalkDomination   --graph=../../raid0_defghij/Yahoo/yahoo-webmap.txt --nshards=25 --N=1413511394 --w=1 --niters=6 --s=9
done
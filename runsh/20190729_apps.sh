# #!/bin/bash

# # mvn assembly:assembly -DdescriptorId=jar-with-dependencies

echo "2019.7.29 " >> drunkardmob.statistics
echo "random walks applications performance comparison (clear pagecache each time) in 64GB R730, HDD, dataset = Friendster" >> drunkardmob.statistics
echo "Turn on Page Cache, clear pagecache each time, nshards = 10" >> drunkardmob.statistics

### 64GB R730, SSD, Friendster
################################################################################################
echo "App = PPR" >> drunkardmob.statistics
for(( times = 0; times < 5; times++))
do
    echo "times = " $times " from echo"
    free -m
    sync; echo 1 > /proc/sys/vm/drop_caches
    free -m
    java -Xmx40960m -cp target/graphchi-java-0.2.2-jar-with-dependencies.jar edu.cmu.graphchi.apps.randomwalks.PersonalizedPageRank  --graph=../../sdl/Friendster/out.friendster-reorder --nshards=10 --firstsource=13 --nsources=1 --walkspersource=2000 --niters=10
done

### 64GB R730, SSD, Friendster
################################################################################################
echo "App = SimRank" >> drunkardmob.statistics
for(( times = 0; times < 5; times++))
do
    echo "times = " $times " from echo"
    free -m
    sync; echo 1 > /proc/sys/vm/drop_caches
    free -m
    java -Xmx40960m -cp target/graphchi-java-0.2.2-jar-with-dependencies.jar edu.cmu.graphchi.apps.randomwalks.SimRank  --graph=../../sdl/Friendster/out.friendster-reorder --nshards=10 --a=12 --b=13 --w=2000 --niters=11
done

### 64GB R730, SSD, Friendster
################################################################################################
echo "App = Graphlet" >> drunkardmob.statistics
for(( times = 0; times < 5; times++))
do
    echo "times = " $times " from echo"
    free -m
    sync; echo 1 > /proc/sys/vm/drop_caches
    free -m
    java -Xmx40960m -cp target/graphchi-java-0.2.2-jar-with-dependencies.jar edu.cmu.graphchi.apps.randomwalks.Graphlet  --graph=../../sdl/Friendster/out.friendster-reorder --nshards=10 --N=68349467 --R=100000 --L=4 --s=13
done

### 64GB R730, SSD, Friendster
################################################################################################
echo "App = RandomWalkDomination" >> drunkardmob.statistics
for(( times = 0; times < 5; times++))
do
    echo "times = " $times " from echo"
    free -m
    sync; echo 1 > /proc/sys/vm/drop_caches
    free -m
    java -Xmx40960m -cp target/graphchi-java-0.2.2-jar-with-dependencies.jar edu.cmu.graphchi.apps.randomwalks.RandomWalkDomination   --graph=../../sdl/Friendster/out.friendster-reorder --nshards=10 --N=68349467 --w=1 --niters=6 --s=13
done



echo "2019.7.7 " >> drunkardmob.statistics
echo "random walks applications performance comparison (clear pagecache each time) in 64GB R730, dataset = Yahoo" >> drunkardmob.statistics
echo "Turn on Page Cache, clear pagecache each time, nshards = 25" >> drunkardmob.statistics

### 64GB R730, SSD, Yahoo
################################################################################################
echo "App = PPR" >> drunkardmob.statistics
for(( times = 0; times < 5; times++))
do
    echo "times = " $times " from echo"
    free -m
    sync; echo 1 > /proc/sys/vm/drop_caches
    free -m
    java -Xmx40960m -cp target/graphchi-java-0.2.2-jar-with-dependencies.jar edu.cmu.graphchi.apps.randomwalks.PersonalizedPageRank  --graph=../../sdl/Yahoo/yahoo-webmap.txt --nshards=25 --firstsource=9 --nsources=1 --walkspersource=2000 --niters=10
done

### 64GB R730, SSD, Yahoo
################################################################################################
echo "App = SimRank" >> drunkardmob.statistics
for(( times = 0; times < 5; times++))
do
    echo "times = " $times " from echo"
    free -m
    sync; echo 1 > /proc/sys/vm/drop_caches
    free -m
    java -Xmx40960m -cp target/graphchi-java-0.2.2-jar-with-dependencies.jar edu.cmu.graphchi.apps.randomwalks.SimRank  --graph=../../sdl/Yahoo/yahoo-webmap.txt --nshards=25 --a=4 --b=9 --w=2000 --niters=11
done

### 64GB R730, SSD, Yahoo
################################################################################################
echo "App = Graphlet" >> drunkardmob.statistics
for(( times = 0; times < 5; times++))
do
    echo "times = " $times " from echo"
    free -m
    sync; echo 1 > /proc/sys/vm/drop_caches
    free -m
    java -Xmx40960m -cp target/graphchi-java-0.2.2-jar-with-dependencies.jar edu.cmu.graphchi.apps.randomwalks.Graphlet  --graph=../../sdl/Yahoo/yahoo-webmap.txt --nshards=25 --N=1413511394 --R=100000 --L=4 --s=9
done

### 64GB R730, SSD, Yahoo
################################################################################################
echo "App = RandomWalkDomination" >> drunkardmob.statistics
for(( times = 0; times < 5; times++))
do
    echo "times = " $times " from echo"
    free -m
    sync; echo 1 > /proc/sys/vm/drop_caches
    free -m
    java -Xmx40960m -cp target/graphchi-java-0.2.2-jar-with-dependencies.jar edu.cmu.graphchi.apps.randomwalks.RandomWalkDomination   --graph=../../sdl/Yahoo/yahoo-webmap.txt --nshards=25 --N=1413511394 --w=1 --niters=6 --s=9
done

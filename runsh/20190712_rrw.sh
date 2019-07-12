# #!/bin/bash

# # mvn assembly:assembly -DdescriptorId=jar-with-dependencies

echo "2019.7.11 " >> drunkardmob.statistics
echo "Raw random walks performance comparison (clear pagecache each time) in 64GB R730, dataset = Yahoo" >> drunkardmob.statistics
echo "Turn on Page Cache, clear pagecache each time, nshards = 25" >> drunkardmob.statistics

### 64GB R730, SSD, Yahoo
################################################################################################
echo "L = 10, vary R" >> drunkardmob.statistics
for(( R = 1000; R <= 10000000000; R*=10))
do
    echo "L = 10, vary R, R = " $R >> drunkardmob.statistics
    for(( times = 0; times < 5; times++))
    do
        echo "times = " $times " from echo"
        free -m
        sync; echo 1 > /proc/sys/vm/drop_caches
        free -m
        java -Xmx40960m -cp target/graphchi-java-0.2.2-jar-with-dependencies.jar edu.cmu.graphchi.apps.randomwalks.RawRandomWalks   --graph=../../raid0_defghij/Yahoo/yahoo-webmap.txt --nshards=25 --N=1413511394 --R=$R --L=10 --s=9
    done
done

### 64GB R730, SSD, Yahoo
################################################################################################
echo "R = 100000, vary L" >> drunkardmob.statistics
for(( L = 4; L <= 4096; L*=2))
do
    echo "R = 100000, vary L, L = " $L >> drunkardmob.statistics
    for(( times = 0; times < 5; times++))
    do
        echo "times = " $times " from echo"
        free -m
        sync; echo 1 > /proc/sys/vm/drop_caches
        free -m
        java -Xmx40960m -cp target/graphchi-java-0.2.2-jar-with-dependencies.jar edu.cmu.graphchi.apps.randomwalks.RawRandomWalks   --graph=../../raid0_defghij/Yahoo/yahoo-webmap.txt --nshards=25 --N=1413511394 --R=100000 --L=$L --s=9
    done
done

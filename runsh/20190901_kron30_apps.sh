# #!/bin/bash

# # mvn assembly:assembly -DdescriptorId=jar-with-dependencies

# echo "2019.8.31 " >> drunkardmob.statistics
# echo "random walks applications performance comparison (clear pagecache each time) in 64GB R730, HDD, dataset = Kron30" >> drunkardmob.statistics
# echo "Turn on Page Cache, clear pagecache each time, nshards = 10" >> drunkardmob.statistics

# ### 64GB R730, SSD, Kron30
# ################################################################################################
# echo "App = PPR" >> drunkardmob.statistics
# for(( times = 0; times < 5; times++))
# do
#     echo "times = " $times " from echo"
#     free -m
#     sync; echo 1 > /proc/sys/vm/drop_caches
#     free -m
#     java -Xmx40960m -cp target/graphchi-java-0.2.2-jar-with-dependencies.jar edu.cmu.graphchi.apps.randomwalks.PersonalizedPageRank  --graph=../../raid0_mnop/Kron30/kron30_32-sorted.txt --nshards=125 --firstsource=0 --nsources=1 --walkspersource=2000 --niters=10
# done

# ### 64GB R730, SSD, Kron30
# ################################################################################################
# echo "App = SimRank" >> drunkardmob.statistics
# for(( times = 0; times < 5; times++))
# do
#     echo "times = " $times " from echo"
#     free -m
#     sync; echo 1 > /proc/sys/vm/drop_caches
#     free -m
#     java -Xmx40960m -cp target/graphchi-java-0.2.2-jar-with-dependencies.jar edu.cmu.graphchi.apps.randomwalks.SimRank  --graph=../../raid0_mnop/Kron30/kron30_32-sorted.txt --nshards=125 --a=0 --b=6 --w=2000 --niters=11
# done

### 64GB R730, SSD, Kron30
################################################################################################
echo "App = Graphlet" >> drunkardmob.statistics
for(( times = 0; times < 5; times++))
do
    echo "times = " $times " from echo"
    free -m
    sync; echo 1 > /proc/sys/vm/drop_caches
    free -m
    java -Xmx40960m -cp target/graphchi-java-0.2.2-jar-with-dependencies.jar edu.cmu.graphchi.apps.randomwalks.Graphlet  --graph=../../raid0_mnop/Kron30/kron30_32-sorted.txt --nshards=125 --N=1073741823 --R=100000 --L=4 --s=0
done

### 64GB R730, SSD, Kron30
################################################################################################
echo "App = RandomWalkDomination" >> drunkardmob.statistics
for(( times = 0; times < 5; times++))
do
    echo "times = " $times " from echo"
    free -m
    sync; echo 1 > /proc/sys/vm/drop_caches
    free -m
    java -Xmx40960m -cp target/graphchi-java-0.2.2-jar-with-dependencies.jar edu.cmu.graphchi.apps.randomwalks.RandomWalkDomination   --graph=../../raid0_mnop/Kron30/kron30_32-sorted.txt --nshards=125 --N=1073741823 --w=1 --niters=6 --s=0
done


# echo "2019.8.29 " >> drunkardmob.statistics
# echo "random walks applications performance comparison (clear pagecache each time) in 64GB R730, HDD, dataset = Kron31" >> drunkardmob.statistics
# echo "Turn on Page Cache, clear pagecache each time, nshards = 10" >> drunkardmob.statistics

# ### 64GB R730, SSD, Kron31
# ################################################################################################
# echo "App = PPR" >> drunkardmob.statistics
# for(( times = 0; times < 5; times++))
# do
#     echo "times = " $times " from echo"
#     free -m
#     sync; echo 1 > /proc/sys/vm/drop_caches
#     free -m
#     java -Xmx40960m -cp target/graphchi-java-0.2.2-jar-with-dependencies.jar edu.cmu.graphchi.apps.randomwalks.PersonalizedPageRank  --graph=../../raid0_defghij/Kron31/kron31_32-sorted.txt --nshards=250 --firstsource=0 --nsources=1 --walkspersource=2000 --niters=10
# done

# ### 64GB R730, SSD, Kron31
# ################################################################################################
# echo "App = SimRank" >> drunkardmob.statistics
# for(( times = 0; times < 5; times++))
# do
#     echo "times = " $times " from echo"
#     free -m
#     sync; echo 1 > /proc/sys/vm/drop_caches
#     free -m
#     java -Xmx40960m -cp target/graphchi-java-0.2.2-jar-with-dependencies.jar edu.cmu.graphchi.apps.randomwalks.SimRank  --graph=../../raid0_defghij/Kron31/kron31_32-sorted.txt --nshards=250 --a=0 --b=6 --w=2000 --niters=11
# done

# ### 64GB R730, SSD, Kron31
# ################################################################################################
# echo "App = Graphlet" >> drunkardmob.statistics
# for(( times = 0; times < 5; times++))
# do
#     echo "times = " $times " from echo"
#     free -m
#     sync; echo 1 > /proc/sys/vm/drop_caches
#     free -m
#     java -Xmx40960m -cp target/graphchi-java-0.2.2-jar-with-dependencies.jar edu.cmu.graphchi.apps.randomwalks.Graphlet  --graph=../../raid0_defghij/Kron31/kron31_32-sorted.txt --nshards=250 --N=2147483648 --R=100000 --L=4 --s=0
# done

# ### 64GB R730, SSD, Kron31
# ################################################################################################
# echo "App = RandomWalkDomination" >> drunkardmob.statistics
# for(( times = 0; times < 5; times++))
# do
#     echo "times = " $times " from echo"
#     free -m
#     sync; echo 1 > /proc/sys/vm/drop_caches
#     free -m
#     java -Xmx40960m -cp target/graphchi-java-0.2.2-jar-with-dependencies.jar edu.cmu.graphchi.apps.randomwalks.RandomWalkDomination   --graph=../../raid0_defghij/Kron31/kron31_32-sorted.txt --nshards=250 --N=2147483648 --w=1 --niters=6 --s=0
# done

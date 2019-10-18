# #!/bin/bash

# # mvn assembly:assembly -DdescriptorId=jar-with-dependencies

java -Xmx40960m -cp target/graphchi-java-0.2.2-jar-with-dependencies.jar edu.cmu.graphchi.apps.randomwalks.PersonalizedPageRank  --graph=../../sdk/Friendster/out.friendster-reorder --nshards=10 --f=12 --s=1 --w=1000 --niters=2

processWalksAtVertex:
if(vertex.getId()==12)
            logger.info(" numOutEdges = " + numOutEdges + ", numInEdges = " + numInEdges); //16


java -Xmx40960m -cp target/graphchi-java-0.2.2-jar-with-dependencies.jar edu.cmu.graphchi.apps.randomwalks.RawRandomWalks  --graph=../../raid0_defghij/Friendster/out.friendster-reorder --nshards=10 --N=68347467 --R=1000000 --L=10 --s=120

java -Xmx40960m -cp target/graphchi-java-0.2.2-jar-with-dependencies.jar edu.cmu.graphchi.apps.randomwalks.RawRandomWalks  --graph=../../raid0_defghij/Yahoo/yahoo-webmap.txt --nshards=25 --N=1413511394 --R=1000000000 --L=10 --s=12

echo "2019.9.22 " >> drunkardmob.statistics
echo "Raw random walks performance comparison (clear pagecache each time) in 64GB R730, dataset = Twitter" >> drunkardmob.statistics
echo "Turn on Page Cache, clear pagecache each time, nshards = 5" >> drunkardmob.statistics

### 64GB R730, SSD, Twitter
################################################################################################
echo "############################################################################################" >> drunkardmob.statistics
echo "L = 10, vary R" >> drunkardmob.statistics
echo "############################################################################################" >> drunkardmob.statistics
for(( R = 1000; R <= 100000000; R*=100))
do
    echo "L = 10, vary R, R = " $R >> drunkardmob.statistics
    for(( times = 0; times < 5; times++))
    do
        echo "times = " $times " from echo"
        free -m
        sync; echo 1 > /proc/sys/vm/drop_caches
        free -m
        java -Xmx40960m -cp target/graphchi-java-0.2.2-jar-with-dependencies.jar edu.cmu.graphchi.apps.randomwalks.RawRandomWalks  --graph=../../raid0_defghij/Twitter/twitter_rv.net --nshards=5 --N=61578415 --R=$R --L=10 --s=12
    done
done

echo "2019.9.22 " >> drunkardmob.statistics
echo "Raw random walks performance comparison (clear pagecache each time) in 64GB R730, dataset = Friendster" >> drunkardmob.statistics
echo "Turn on Page Cache, clear pagecache each time, nshards = 10" >> drunkardmob.statistics

### 64GB R730, SSD, Friendster
################################################################################################
echo "############################################################################################" >> drunkardmob.statistics
echo "L = 10, vary R" >> drunkardmob.statistics
echo "############################################################################################" >> drunkardmob.statistics
for(( R = 1000000000; R <= 10000000000; R*=10))
do
    echo "L = 10, vary R, R = " $R >> drunkardmob.statistics
    for(( times = 0; times < 5; times++))
    do
        echo "times = " $times " from echo"
        free -m
        sync; echo 1 > /proc/sys/vm/drop_caches
        free -m
        java -Xmx40960m -cp target/graphchi-java-0.2.2-jar-with-dependencies.jar edu.cmu.graphchi.apps.randomwalks.RawRandomWalks  --graph=../../raid0_defghij/Friendster/out.friendster-reorder --nshards=10 --N=68347467 --R=$R --L=10 --s=12
    done
done

# ### 64GB R730, SSD, Twitter
# ################################################################################################
# echo "############################################################################################" >> drunkardmob.statistics
# echo "R = 100000, vary L" >> drunkardmob.statistics
# echo "############################################################################################" >> drunkardmob.statistics
# for(( L = 4; L <= 1024; L*=2))
# do
#     echo "R = 100000, vary L, L = " $L >> drunkardmob.statistics
#     for(( times = 0; times < 2; times++))
#     do
#         echo "times = " $times " from echo"
#         free -m
#         sync; echo 1 > /proc/sys/vm/drop_caches
#         free -m
#         java -Xmx40960m -cp target/graphchi-java-0.2.2-jar-with-dependencies.jar edu.cmu.graphchi.apps.randomwalks.RawRandomWalks  --graph=../../raid0_defghij/Twitter/twitter_rv.net --nshards=5 --N=61578415 --R=100000 --L=$L --s=12
#     done
# done

# echo "2019.9.1 " >> drunkardmob.statistics
# echo "Raw random walks performance comparison (clear pagecache each time) in 64GB R730, dataset = Kron30" >> drunkardmob.statistics
# echo "Turn on Page Cache, clear pagecache each time, nshards = 125" >> drunkardmob.statistics

# ### 64GB R730, SSD, Kron30
# ################################################################################################
# echo "############################################################################################" >> drunkardmob.statistics
# echo "L = 10, vary R" >> drunkardmob.statistics
# echo "############################################################################################" >> drunkardmob.statistics
# for(( R = 1000; R <= 1000000000; R*=10))
# do
#     echo "L = 10, vary R, R = " $R >> drunkardmob.statistics
#     for(( times = 0; times < 5; times++))
#     do
#         echo "times = " $times " from echo"
#         free -m
#         sync; echo 1 > /proc/sys/vm/drop_caches
#         free -m
#         java -Xmx40960m -cp target/graphchi-java-0.2.2-jar-with-dependencies.jar edu.cmu.graphchi.apps.randomwalks.RawRandomWalks  --graph=../../raid0_mnop/Kron30/kron30_32-sorted.txt --nshards=125 --N=1073741823 --R=$R --L=10 --s=0
#     done
# done

# ### 64GB R730, SSD, Kron30
# ################################################################################################
# echo "############################################################################################" >> drunkardmob.statistics
# echo "R = 100000, vary L" >> drunkardmob.statistics
# echo "############################################################################################" >> drunkardmob.statistics
# for(( L = 32; L <= 4096; L*=2))
# do
#     echo "R = 100000, vary L, L = " $L >> drunkardmob.statistics
#     for(( times = 0; times < 2; times++))
#     do
#         echo "times = " $times " from echo"
#         free -m
#         sync; echo 1 > /proc/sys/vm/drop_caches
#         free -m
#         java -Xmx40960m -cp target/graphchi-java-0.2.2-jar-with-dependencies.jar edu.cmu.graphchi.apps.randomwalks.RawRandomWalks  --graph=../../raid0_mnop/Kron30/kron30_32-sorted.txt --nshards=125 --N=1073741823 --R=100000 --L=$L --s=0
#     done
# done

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

# ### 64GB R730, SSD, Kron30
# ################################################################################################
# echo "App = Graphlet" >> drunkardmob.statistics
# for(( times = 0; times < 5; times++))
# do
#     echo "times = " $times " from echo"
#     free -m
#     sync; echo 1 > /proc/sys/vm/drop_caches
#     free -m
#     java -Xmx40960m -cp target/graphchi-java-0.2.2-jar-with-dependencies.jar edu.cmu.graphchi.apps.randomwalks.Graphlet  --graph=../../raid0_mnop/Kron30/kron30_32-sorted.txt --nshards=125 --N=1073741823 --R=100000 --L=4 --s=0
# done

# ### 64GB R730, SSD, Kron30
# ################################################################################################
# echo "App = RandomWalkDomination" >> drunkardmob.statistics
# for(( times = 0; times < 5; times++))
# do
#     echo "times = " $times " from echo"
#     free -m
#     sync; echo 1 > /proc/sys/vm/drop_caches
#     free -m
#     java -Xmx40960m -cp target/graphchi-java-0.2.2-jar-with-dependencies.jar edu.cmu.graphchi.apps.randomwalks.RandomWalkDomination   --graph=../../raid0_mnop/Kron30/kron30_32-sorted.txt --nshards=125 --N=1073741823 --w=1 --niters=6 --s=0
# done


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

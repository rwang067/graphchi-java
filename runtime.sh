# !/bin/bash

# mvn assembly:assembly -DdescriptorId=jar-with-dependencies

# # 2018.12.26
# # Friendster MSPPR
#     echo "2018.12.26 count the performance of Drunkardmob" >> drunkardmob.statistics 
#     echo "app = Drunkardmob-MSPPR, dataset = Friendster" >> drunkardmob.statistics 

# # numsources = 1000, walkspersource = 2000, firstsource = 0
#     echo "numsources = 1000, walkspersource = 2000, firstsource = 12" >> drunkardmob.statistics 
#     for(( nsources = 1000; nsources <= 10000; nsources*=10))
#     do
#         echo "nsources = " $nsources >> drunkardmob.statistics 
# 	    for(( times = 0; times < 3; times++))
# 	    do
# 	        echo "times = " $times " from echo"
#             java -Xmx1024m -cp target/graphchi-java-0.2.2-jar-with-dependencies.jar edu.cmu.graphchi.apps.randomwalks.PersonalizedPageRank  --graph=../DataSet/Friendster/out.friendster-reorder --nshards=100 --niters=10 --nsources=$nsources --firstsource=12 --walkspersource=2000
#             done
# 	done

# # 2019.1.4
# # Friendster MSPPR
#     echo "2019.1.4 count the performance of Drunkardmob" >> drunkardmob.statistics 
#     echo "app = Drunkardmob-MSPPR, dataset = Twitter" >> drunkardmob.statistics 

# # numsources = 1000, walkspersource = 2000, firstsource = 0
#     echo "numsources = 1000, walkspersource = 2000, firstsource = 12" >> drunkardmob.statistics 
#     for(( nsources = 1; nsources <= 100000; nsources*=10))
#     do
#         echo "nsources = " $nsources >> drunkardmob.statistics 
# 	    for(( times = 0; times < 3; times++))
# 	    do
# 	        echo "times = " $times " from echo"
#             java -Xmx1024m -cp target/graphchi-java-0.2.2-jar-with-dependencies.jar edu.cmu.graphchi.apps.randomwalks.PersonalizedPageRank  --graph=../DataSet/Twitter/twitter_rv.net --nshards=60 --niters=10 --nsources=$nsources --firstsource=13 --walkspersource=2000
#             done
# 	done

# 2019.1.5
# Friendster MSPPR
    echo "2019.1.5 count the performance of Drunkardmob in Yahoo on ccc" >> drunkardmob.statistics 
    echo "app = Drunkardmob-MSPPR, dataset = Yahoo" >> drunkardmob.statistics 

    # walkspersource = 2000, firstsource = 9
    echo "walkspersource = 2000, firstsource = 9" >> drunkardmob.statistics 
    for(( nsources = 1; nsources <= 100000; nsources*=10))
    do
        echo "nsources = " $nsources >> drunkardmob.statistics 
	    for(( times = 0; times < 3; times++))
	    do
	        echo "times = " $times " from echo"
            java -Xmx10240m -cp target/graphchi-java-0.2.2-jar-with-dependencies.jar edu.cmu.graphchi.apps.randomwalks.PersonalizedPageRank  --graph=../../raid0_efghij/Yahoo/yahoo-webmap.txt --nshards=100 --niters=10 --nsources=$nsources --firstsource=9 --walkspersource=2000
            done
	done

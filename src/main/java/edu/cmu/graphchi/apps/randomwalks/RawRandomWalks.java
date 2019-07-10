package edu.cmu.graphchi.apps.randomwalks;

import edu.cmu.graphchi.*;
import edu.cmu.graphchi.preprocessing.FastSharder;
import edu.cmu.graphchi.walks.DrunkardContext;
import edu.cmu.graphchi.walks.DrunkardJob;
import edu.cmu.graphchi.walks.DrunkardMobEngine;
import edu.cmu.graphchi.walks.IntDrunkardContext;
import edu.cmu.graphchi.walks.IntDrunkardFactory;
import edu.cmu.graphchi.walks.IntWalkArray;
import edu.cmu.graphchi.walks.WalkUpdateFunction;
import edu.cmu.graphchi.walks.WalkArray;
import org.apache.commons.cli.*;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Random;
import java.util.logging.Logger;

/**
 * Computes estimate of personalized pagerank using the DrunkardMobEngine.
 * <b>Note:</b> this version omits walks to adjacent vertices, and thus could be a
 * basis for recommendation engine. To remove that functionality, modify method
 * getNotTrackedVertices()
 * @author Aapo Kyrola
 */
public class RawRandomWalks implements WalkUpdateFunction<EmptyType, EmptyType> {

    private static double RESET_PROBABILITY = 0.15;
    private static Logger logger = ChiLogger.getLogger("raw-random-walks");
    private DrunkardMobEngine<EmptyType, EmptyType>  drunkardMobEngine;
    private String baseFilename;
    private int N;
    private int R;
    private int L;
    private int s;
    // private String companionUrl;
    //20190619 by Rui -- used for counting IO utilizations
    // int nThreads;
    // private int[] numedges;
    // private int[] used_edges;

    public RawRandomWalks(String companionUrl, String baseFilename, int nShards, int N, int R, int L, int s) throws Exception{
        this.baseFilename = baseFilename;
        this.drunkardMobEngine = new DrunkardMobEngine<EmptyType, EmptyType>(baseFilename, nShards,
                new IntDrunkardFactory());

        // this.companionUrl = companionUrl;
        this.N = N;
        this.R = R;
        this.L = L;
        this.s = s;

        // /////////////////////////
        // (new File("drunkardmob_utilization.csv")).delete();

        // numedges = new int[nShards];
        // BufferedReader rd = new BufferedReader(new FileReader(new File(ChiFilenames.getFilenameIntervals(baseFilename, nShards)+".edgenums")));
        // String line;
        // for(int i = 0; i < nShards; i++) {
        //     line = rd.readLine();
        //     numedges[i] = Integer.parseInt(line);
        // }
        
        // nThreads = Runtime.getRuntime().availableProcessors();
        // used_edges = new int[nThreads];
        // for(int i=0; i<nThreads; i++){
        //     used_edges[i] = 0;
        // }
    }

    private void execute(int numIters) throws Exception {
        /* Configure walk sources. Note, GraphChi's internal ids are used. */
        DrunkardJob drunkardJob = this.drunkardMobEngine.addJob("personalizedPageRank",
                EdgeDirection.OUT_EDGES, this);

        //start walks
        logger.info("configureRandomWalks, R = " + R);
        // drunkardJob.configureRandomWalks(R, 1);
        drunkardJob.configureSourceRangeInternalIds(s, 1, R);
        drunkardMobEngine.run(numIters);
    }

    /**
     * WalkUpdateFunction interface implementations
     */
    @Override
    public void processWalksAtVertex(WalkArray walkArray,
                                     ChiVertex<EmptyType, EmptyType> vertex,
                                     DrunkardContext drunkardContext_,
                                     Random randomGenerator) {
        int[] walks = ((IntWalkArray)walkArray).getArray();
        IntDrunkardContext drunkardContext = (IntDrunkardContext) drunkardContext_;
        int numWalks = walks.length;
        int numOutEdges = vertex.numOutEdges();

        // logger.info("processWalksAtVertex : " + vertex.getId());
        // Advance each walk to a random out-edge (if any)
        if (numOutEdges > 0) {
            
            //***********Rui************
            // used_edges[(int)(Thread.currentThread().getId())%nThreads] += numWalks;

            for(int i=0; i < numWalks; i++) {
                int walk = walks[i];

                // Reset?
                if (randomGenerator.nextDouble() < RESET_PROBABILITY) {
                    int nextHop  = (int)( Math.random() * N );
                    boolean shouldTrack = !drunkardContext.isWalkStartedFromVertex(walk);
                    drunkardContext.forwardWalkTo(walk, nextHop, shouldTrack);
                    ;//drunkardContext.resetWalk(walk, false);
                } else {
                    int nextHop  = vertex.getOutEdgeId(randomGenerator.nextInt(numOutEdges));

                    // Optimization to tell the manager that walks that have just been started
                    // need not to be tracked.
                    boolean shouldTrack = !drunkardContext.isWalkStartedFromVertex(walk);
                    drunkardContext.forwardWalkTo(walk, nextHop, shouldTrack);
                }
            }

        } else {
            // Reset all walks -- no where to go from here
            for(int i=0; i < numWalks; i++) {
                int walk = walks[i];
                int nextHop  = (int)( Math.random() * N );
                boolean shouldTrack = !drunkardContext.isWalkStartedFromVertex(walk);
                drunkardContext.forwardWalkTo(walk, nextHop, shouldTrack);
                ;//drunkardContext.resetWalk(walks[i], false);
            }
        }
    }



    @Override
    /**
     * Instruct drunkardMob not to track visits to this vertex's immediate out-neighbors.
     */
    public int[] getNotTrackedVertices(ChiVertex<EmptyType, EmptyType> vertex) {
        int[] notCounted = new int[1 + vertex.numOutEdges()];
        for(int i=0; i < vertex.numOutEdges(); i++) {
            notCounted[i + 1] = vertex.getOutEdgeId(i);
        }
        notCounted[0] = vertex.getId();
         return notCounted;
    }

    protected static FastSharder createSharder(String graphName, int numShards) throws IOException {
        return new FastSharder<EmptyType, EmptyType>(graphName, numShards, null, null, null, null);
    }

    @Override
    public void compUtilization(int execInterval){
        // logger.info("compUtilization...");
        // for(int i = 1; i < nThreads; i++){
        //     used_edges[0] += used_edges[i];
        // }
        // float utilization = (float)used_edges[0] / (float)numedges[execInterval];
        // try{
        //     FileWriter writer = new FileWriter("drunkardmob_utilization.csv", true);   
        //     writer.write(execInterval + "\t" + numedges[execInterval] + "\t" + used_edges[0] + "\t" + utilization + "\n" );   
        //     writer.close();
        // } catch(IOException ie) {
        //     ie.printStackTrace();
        // } 
        // // logstream(LOG_DEBUG) << "IO utilization = " << utilization << std::endl;

        // for(int i=0; i<nThreads; i++){
        //     used_edges[i] = 0;
        // }
    }

    public static void main(String[] args) throws Exception {

        /* Configure command line */
        Options cmdLineOptions = new Options();
        cmdLineOptions.addOption("g", "graph", true, "graph file name");
        cmdLineOptions.addOption("n", "nshards", true, "number of shards");
        cmdLineOptions.addOption("t", "filetype", true, "filetype (edgelist|adjlist)");
        cmdLineOptions.addOption("N", "nvertices", true, "id of the first source vertex (internal id)");
        cmdLineOptions.addOption("R", "nwalks", true, "number of walks");
        cmdLineOptions.addOption("L", "niters", true, "number of iterations");
        cmdLineOptions.addOption("s", "source", true, "fake source");
        cmdLineOptions.addOption("u", "companion", true, "RMI url to the DrunkardCompanion or 'local' (default)");

        try {

            /* Parse command line */
            CommandLineParser parser = new PosixParser();
            CommandLine cmdLine =  parser.parse(cmdLineOptions, args);

            /**
             * Preprocess graph if needed
             */
            String baseFilename = cmdLine.getOptionValue("graph");
            int nShards = Integer.parseInt(cmdLine.getOptionValue("nshards"));
            String fileType = (cmdLine.hasOption("filetype") ? cmdLine.getOptionValue("filetype") : null);

            /**
             * Mkdir --20190619 by Rui
             */
            File dirpath = new File(baseFilename+"_DrunkardMob/");
            if ( !dirpath.exists()){
                dirpath.mkdir();
            }
            File dirpath1 = new File(baseFilename+ChiFilenames.graphFilePrefix);
            logger.info(baseFilename+ChiFilenames.graphFilePrefix);
            if ( !dirpath1.exists()){
                dirpath1.mkdir();
            }

            /* Create shards */
            if (baseFilename.equals("pipein")) {     // Allow piping graph in
                FastSharder sharder = createSharder(baseFilename, nShards);
                sharder.shard(System.in, fileType);
            } else {
                FastSharder sharder = createSharder(baseFilename, nShards);
                if (!new File(ChiFilenames.getFilenameIntervals(baseFilename, nShards)).exists()) {
                    sharder.shard(new FileInputStream(new File(baseFilename)), fileType);
                } else {
                    logger.info("Found shards -- no need to pre-process");
                }
            }

            /**
             * Delete shoverl files --20190620 by Rui
             */
            for(int i = 0; i < nShards; i++){
                File f = new File(baseFilename + ChiFilenames.graphFilePrefix + "shovel."+i);
                if ( !f.exists()){
                    f.delete();
                }
            }

            // Run
            int N = Integer.parseInt(cmdLine.getOptionValue("nvertices"));
            int R = Integer.parseInt(cmdLine.getOptionValue("nwalks"));
            int L = Integer.parseInt(cmdLine.getOptionValue("niters"));
            int s = Integer.parseInt(cmdLine.getOptionValue("source"));
            String companionUrl = cmdLine.hasOption("companion") ? cmdLine.getOptionValue("companion") : "local";

            RawRandomWalks pp = new RawRandomWalks(companionUrl, baseFilename, nShards, N, R, L, s);
            pp.execute(L);
            System.exit(0);
        } catch (Exception err) {
            err.printStackTrace();
            // automatically generate the help statement
            HelpFormatter formatter = new HelpFormatter();
            formatter.printHelp("Raw Random Walks", cmdLineOptions);
        }
    }
}

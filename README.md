# Flexus Debugger #

Flexus Debugger is a debugging tool which can help analyze Flexus. Flexus Debugger uses Python3 script to get important lines from the Flexus log file and to systemize them. It also uses neo4j, a high-performance Graph Database, which supports all the features expected of a mature database including query language. You can learn more about Neo4j [here][neo4jweb]

# How to start Flexus Debugger #

Every work of Flexus Debugger, such as starting Neo4j database server, parsing the log file, and inserting the parsed data into the Neo4j, can be run with a single Docker image.

Before you start, make sure you have ***'debug.out'*** file under 'Flexus-Debugging/' directory.     
  *(Please refer **How to make debug.out** if you need help)*

You can build docker with following command.
<pre><code>$ sudo chown -R root:root data
$ sudo docker build -t test:0.1 .</code></pre>

Run the docker.
<pre><code>$ sudo docker run --publish=7474:7474 --publish=7687:7687 --volume=$HOME/docker_test/data:/data --volume=$HOME/docker_test/logs:/logs test:0.1 </pre></code>

First, you can see the Neo4j server running in the background.
If it runs successfully, you can find following message.

<pre><code>...
======== Neo4j 3.4.4 ========
Starting...
Bolt enabled on 0.0.0.0:7687.
Started.
Remote interface available at http://localhost:7474/</code></pre>

After a few seconds, log parsing script will run and terminate with following message.

<pre><code>...
IMPORT DONE in 5s 250ms.
Imported:
   166237 nodes
   387298 relationships
   1738752 properties
Peak memory usage: 1.03 GB</code></pre>

Then, Neo4j server will be terminated and restarted.
After seeing Neo4j ***Started*** message, you can use Neo4j browser to analyze your log file.

***(Neo4j Browser: http://localhost:7474/)***

# How to use Flexus Debugger #


# How to make debug.out #
Before run Flexus, you have to apply the patch to make the simulator have more verbosity.
You can find the patch file named ***link.patch***

## Compiling ##
**Trace**
<pre><code>$ make -j CMP.L2Shared.Trace </code></pre>

**Timing**
<pre><code>$ make -j CMP.L2SharedNUCA.OoO </code></pre>

## Running ##
**Trace**
<pre><code>$ run_job -clobber -cfg cortex-a15-1core-1024kl2 -local -run trace -job trace-a15-1core-1024kl2 CMP.L2Shared.Trace nutch/1cpu </code></pre>

**Flexpoint**
<pre><code>$ run_job -clobber -cfg cortex-a15-1core-1024kl2 -local -run flexpoint -dkpt-gen -postprocess "/home/parsacom/tools/flexus/postprocess_ckptgen.sh flexpoint 20 cortex-a15-1core-1024kl2" -job flexpoint-a15-1core-1024kl2 CMP.L2Shared.Trace nutch/1cpu</code></pre>

**Timing**
<pre><code>$ run_job -clobber -ma -cfg cortex-a15-1core-1024kl2 -local -run timing -job timing-a15-1core-1024kl2-$1 -state cortex-a15-1core-1024kl2 -postprocess "/home/parsacom/tools/flexus/postprocess.sh" CMP.LwSharedNUCA.OoO nutch/1cpu </code></pre>

After these steps, copy the simulator to the **.skel** folder, and run **go.sh** again.
Press Ctrl-c to stop simulation, enable more verbosity by **flexus.debug-set-severity-level vverb**, and hit r to terminate.

Then you can find your **debug.out** with more information. Move the file under the **Flexus-Debugging/** directory. 

[neo4jweb]:https://neo4j.com/ 

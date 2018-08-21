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

Then, first you can see the Neo4j server running in the background.
If it runs successfully, you can view the following message

<pre><code>======== Neo4j 3.4.4 ========
Starting...
Bolt enabled on 0.0.0.0:7687.
Started.
Remote interface available at http://localhost:7474/</code></pre>

After a few seconds, log parsing script will run and terminate with following message.

<pre><code>IMPORT DONE in 5s 250ms.
Imported:
   166237 nodes
   387298 relationships
   1738752 properties
Peak memory usage: 1.03 GB</code></pre>

Then, Neo4j server will be terminated and restarted. 
After seeing Neo4j **Started** message, you can use Neo4j browser to analyze your log file.
**(Neo4j Browser: http://localhost:7474/)**

# How to use Flexus Debugger #


# How to make debug.out #




[neo4jweb]:https://neo4j.com/ 

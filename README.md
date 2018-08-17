# Flexus Debugger #

Flexus Debugger is a debugging tool which can help analyze Flexus. Flexus Debugger uses Python3 script to get important lines from the Flexus log file and to systemize them. It also uses neo4j, a high performance Graph Database,which supports all the features expected of a mature database including query language. You can learn more about Neo4j [here] [neo4jweb]

# How to start Flexus Debugger #

Every work of Flexus Debugger, such as starting Neo4j database server, parsing the logfile, and inserting the parsed data into the Neo4j, can be run with a single Docker image.

Before you start, make sure you have 'debug.out' file under 'Flexus-Debugging/' directory.
Please refer **How to make *debug.out***






[neo4jweb]:https://neo4j.com/ 

# Flexus Debugger #

Flexus Debugger is a debugging tool which can help analyze [Flexus][Flexus]. Flexus Debugger uses Python3 script to get important lines from the Flexus log file and to systemize them. It also uses [Neo4j][neo4jweb], a high-performance Graph Database, which supports all the features expected of a mature database including query language. 

Neo4j: <https://neo4j.com>\n
Flexus: <https://github.com/parsa-epfl/flexus>\n
QFlex: <https://github.com/parsa-epfl/qflex>\n

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

***(Neo4j Browser: http://localhost:7474/)***; Remote access is also supported.

# How to use Flexus Debugger #

![Serial_sample](https://github.com/persona0220/Flexus-Debugging/blob/master/images/serial.png)

Flexus Debugger makes it much easier to analyze the log file of Flexus.

Here is part of the sample *debug.out*.

<pre><code>
108 <MultiNicXImpl.hpp:169> {1606}- 01-nic   Packet contains: MemoryMessage[Fetch Reply]: Addr:0xp:007c4b000 Size:64 Serial: 345 Core: 0 DStream: true Outstanding Msgs: 0 Requires Ack
111 <MemoryNetworkImpl.cpp:287> {1606}- Network Received msg From 1 to 0, on vc 0, serial: 252 Message =  MemoryMessage[Fetch Reply]: Addr:0xp:007c4b000 Size:64 Serial: 345 Core: 0 DStream: true Outstanding Msgs: 0 Requires Ack
122 <CacheController.cpp:1773> {1606}- sys-L1d  sendFront (D-1, I-0) : instr=>> #1076[00] @PC= v:0010647b8 opc=| e403c01d | Disas=lduw [%o7 + %i5], %l2                 {executed} << MemoryMessage[Load Reply]: Addr:0xp:00fd6ff74 Size:4 Serial: 454 Core: 0 DStream: true Outstanding Msgs: 0 Requires Ack
125 <CacheController.cpp:1773> {1606}- sys-L1d  sendFront (D-1, I-0) : instr=>> #1086[00] @PC= v:0010646cc opc=| d25e20a0 | Disas=ldx [%i0 + 160], %o1                  {executed} << MemoryMessage[Load Reply]: Addr:0xp:00800c0a0 Size:8 Serial: 455 Core: 0 DStream: true Outstanding Msgs: 0 Requires Ack
127 <CacheImpl.cpp:238> {1606}- sys-L1d Sent on Port FrontSideOut_D [0]: instr=>> #1076[00] @PC= v:0010647b8 opc=| e403c01d | Disas=lduw [%o7 + %i5], %l2               {executed} << MemoryMessage[Load Reply]: Addr:0xp:00fd6ff74 Size:4 Serial: 454 Core: 0 DStream: true Outstanding Msgs: 0 Requires Ack
131 <CacheImpl.cpp:238> {1606}- sys-L1d Sent on Port FrontSideOut_D [0]: instr=>> #1086[00] @PC= v:0010646cc opc=| d25e20a0 | Disas=ldx [%i0 + 160], %o1                {executed} << MemoryMessage[Load Reply]: Addr:0xp:00800c0a0 Size:8 Serial: 455 Core: 0 DStream: true Outstanding Msgs: 0 Requires Ack
143 <CacheImpl.cpp:170> {1607}- sys-L1d Received on Port FrontSideIn(Request) [0]: instr=>> #1092[00] @PC= v:0010646e8 opc=| d85260fa | Disas=ldsh [%o1 + 250], %o4             {executed} << MemoryMessage[Load Request]: Addr:0xp:00800c0fa Size:2 Serial: 459 Core: 0 DStream: true Outstanding Msgs: 0 Requires Ack
146 <CacheImpl.cpp:170> {1607}- sys-L1d Received on Port FrontSideIn(Request) [0]: instr=>> #1095[00] @PC= v:0010646f4 opc=| f85a60e0 | Disas=ldx [%o1 + 224], %i4              {executed} << MemoryMessage[Load Request]: Addr:0xp:00800c0e0 Size:8 Serial: 460 Core: 0 DStream: true Outstanding Msgs: 0 Requires Ack
149 <CacheController.cpp:1010> {1607}- sys-L1d  scheduling request to bank 0: instr=>> #1092[00] @PC= v:0010646e8 opc=| d85260fa | Disas=ldsh [%o1 + 250], %o4          {executed} << MemoryMessage[Load Request]: Addr:0xp:00800c0fa Size:2 Serial: 459 Core: 0 DStream: true Outstanding Msgs: 0 Requires Ack eL1
150 <CacheController.cpp:1010> {1607}- sys-L1d  scheduling request to bank 0: instr=>> #1095[00] @PC= v:0010646f4 opc=| f85a60e0 | Disas=ldx [%o1 + 224], %i4           {executed} << MemoryMessage[Load Request]: Addr:0xp:00800c0e0 Size:8 Serial: 460 Core: 0 DStream: true Outstanding Msgs: 0 Requires Ack eL1
</code></pre>

You can get some information from each line of the file:

LineNumber <ComponentName:ComponentLineNumber> {Cycle}- [MemoryMessage]: instr=>> #InstructionNumber[CPUID] @PC= opc=| opcode | Disas= Disassembly {Semantic} Addr: Size: Serial: Core: DStream: Outstanding Msgs: 

The debugger parses every line of the log file and categorizes them using Neo4j, so that you can trace and analyze the result more easily. 

Each line in the log file becomes the smallest grey node. 


* **Line**: the smallest grey circles
* **Serial**: the red circle
* **Address**: the green circle
* **Instrunction**: the purple circle

Each line nodes are categorized based on *serial, address*, and *instruction*.

* **Trace**: the yellow graph; You can see the trace of lines visually. 
  Each arrows have **sequence # (cycle diff)**, and each nodes have component name within the circle.

* **Pattern**: the blue circle; Some serials with same trace, which means exactly same number of processes with identical component name, can be categorized as same pattern.


## Style ##

You can import ***Flexus-Debugging/setting/style.grass*** file into your browser by drag&drop to make your graph have better looking.

## Node and Relationships ##

When you open the Neo4j browser, you can see every **Node Labels** and **Relationships**. 
You can list them clicking the name of nodes/relationships. 

## Expand Relationships ##

You can expand a node by double-clicking it. You can see every nodes and relationships of the node, and follow them to debug more easily.


## Browser Settings ##

It shows maximum 25 nodes/relationships by default. You can change this maximum value at **Browser Settings** in the bottom left corner. Or you can use Cypher query langauges instead.

## Cypher query language ##

Cypher is SQL-inspired language for describing patterns in graphs visually using an ASCII-art syntax.
There are some sample scripts in **Flexus-Debugging/setting/Scripts.cypher** file.

  + ***MATCH(n:Serial) RETURN count(n)***

	: This script returns the number of Serials in the log file.
  
  + ***MATCH(a)-[\*]->(n:Serial)-[\*]->(b)<-[\*]-(c) WHERE n.serial="483" RETURN n, a, b, c***

	![serial_sample](https://github.com/persona0220/Flexus-Debugging/blob/master/images/serial.png)

    : This script shows whole information related to 'serial #483'.
	  You can see the address, instruction, pattern and traces of the serial.
 

  + ***MATCH(p:Pattern_Serial)-[\*]->(n)<-[\*0..1]-(m) WHERE p.patternId="P:S:5" RETURN p, n, m***

	![pattern_sample](https://github.com/persona0220/Flexus-Debugging/blob/master/images/pattern.png)

    : This script shows every serial matched to the given pattern, and their information.


  + ***MATCH(n:Addr)-[\*]->(m)<-[\*]-(k) WHERE n.addr="0xp:0080352c0" RETURN n, m, k***

	![addr_sample](https://github.com/persona0220/Flexus-Debugging/blob/master/images/addr_sample.png)

	: This script shows pattern, serials, and instructions related to 'address 0xp:0080352c0". 


Cypher query language is easy and powerful, so you can do much more things with it.

**Neo4j Cypher Refcard 3.4: [here][Refcard]**

**Intro to Cypher: [here][Cypher]**


# How to make debug.out #
Before run Flexus, you need to apply the patch for more verbosity of the simulator.
You can find the patch file named ***link.patch***/ under Flexus-Debugging/ directory.

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
Press Ctrl-c to stop simulation, enable more verbosity by **flexus.debug-set-severity-level vverb**, and hit 'r'.

Then you can find your **debug.out** with more information. Move the file under the **Flexus-Debugging/** directory. 

[Flexus]:https://github.com/parsa-epfl/flexus
[QFlex]:https://github.com/parsa-epfl/qflex
[neo4jweb]:https://neo4j.com/ 
[Refcard]:https://neo4j.com/docs/cypher-refcard/current/
[Cypher]:https://neo4j.com/developer/cypher-query-language/

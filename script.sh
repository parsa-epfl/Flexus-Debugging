exec /sbin/tini -g -- /docker-entrypoint.sh neo4j 
sleep 10

python3 /script.py
mv *.csv /var/lib/neo4j/bin/
cd /var/lib/neo4j/bin

rm -rf /var/lib/neo4j/data/databases/graph.db

./neo4j-admin import --mode=csv --database=graph.db --nodes:Line line.csv --nodes:Serial serial.csv --nodes:Addr addr.csv \
			--nodes:Pattern_addr pattern_addr.csv --nodes:Pattern_Serial pattern_serial.csv \
			--nodes:Trace trace.csv \
			--nodes:Instr instr.csv --nodes:Line_instr instr_line.csv\
			--relationships:done done.csv --relationships:match match.csv --relationships:next next.csv

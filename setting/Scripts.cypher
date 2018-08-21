MATCH(n:Serial) RETURN count(n)
MATCH (p:Pattern_Serial)-[:match]->(serial) RETURN p,serial ORDER BY toInteger(serial.serial) LIMIT 200
MATCH(n:Addr)-[*]->(m)<-[*]-(k) WHERE n.addr="0xp:0080352c0" RETURN n, m, k
MATCH(l)-[*]->(n:Serial)-[*]->(m)<-[*]-(k) WHERE n.serial="483" RETURN n, m, k, l
MATCH(p:Pattern_Serial)-[*]->(n)<-[*0..1]-(m) WHERE p.patternId="P:S:5" RETURN p, n, m

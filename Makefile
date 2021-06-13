default: index cert up

cert: conf/gemini-key.rsa
conf/gemini-key.rsa:
	mkdir -p conf/
	openssl req -x509 -newkey rsa:4096 \
	            -keyout conf/gemini-key.rsa \
	            -out conf/gemini-cert.pem \
	            -days 3650 -nodes \
	            -subj "/CN=jameshunt.us"

index:
	(cat parts/index.gmi && \
	 cd docs/ && \
	 find log -name '*.gmi' | xargs -I@ echo "=> /@") > docs/index.gmi

up: cert
	docker-compose -p gemini up -d

down:
	docker-compose -p gemini down

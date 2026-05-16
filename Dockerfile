FROM postgis/postgis:15-3.3

ENV POSTGRES_PASSWORD=postgres
ENV POSTGRES_DB=nyc

# Copy workshop data loader script
COPY scripts/populate_nyc.sh /docker-entrypoint-initdb.d/populate_nyc.sh
RUN chmod +x /docker-entrypoint-initdb.d/populate_nyc.sh

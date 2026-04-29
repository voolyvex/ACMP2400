FROM anchore/syft:v1.43.0 AS syft
FROM anchore/grype:v0.111.1 AS grype

FROM ubuntu:noble@sha256:c4a8d5503dfb2a3eb8ab5f807da5bc69a85730fb49b5cfca2330194ebcc41c7b

RUN apt-get update \
 && apt-get install --no-install-recommends -y ca-certificates \
 && rm -rf /var/lib/apt/lists/*

COPY --from=syft  /syft  /usr/local/bin/syft
COPY --from=grype /grype /usr/local/bin/grype

WORKDIR /app

COPY entrypoint.sh .

RUN chmod +x entrypoint.sh

ENTRYPOINT ["/app/entrypoint.sh"]
# Generated with Claude Code on 2026-04-23
FROM ubuntu:latest@sha256:84e77dee7d1bc93fb029a45e3c6cb9d8aa4831ccfcc7103d36e876938d28895b

RUN apt-get update && apt-get install --no-install-recommends -y curl ca-certificates && \
    curl -sSfL https://get.anchore.io/syft | sh -s -- -b /usr/local/bin && \
    curl -sSfL https://get.anchore.io/grype | sh -s -- -b /usr/local/bin

WORKDIR /app

COPY entrypoint.sh .

RUN chmod +x entrypoint.sh

ENTRYPOINT ["/app/entrypoint.sh"]

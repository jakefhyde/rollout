FROM ubuntu:20.04

RUN apt-get update && \
    apt-get install -y \
    curl \
    vim \
    bash \
    docker.io

RUN curl -sLf https://storage.googleapis.com/kubernetes-release/release/v1.20.10/bin/linux/amd64/kubectl > /usr/local/bin/kubectl-1.20 \
    && ln -sv /usr/local/bin/kubectl-1.20 /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl*

COPY entrypoint.sh /usr/bin/

CMD ["entrypoint.sh"]

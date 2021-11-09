FROM ubuntu:20.04

RUN apt-get update && \
    apt-get install -y \
    curl \
    docker.io \
    dumb-init

RUN curl -sLf https://storage.googleapis.com/kubernetes-release/release/v1.20.10/bin/linux/amd64/kubectl > /usr/local/bin/kubectl-1.20 \
    && ln -sv /usr/local/bin/kubectl-1.20 /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl*

ENV CRICTL_VERSION="v1.22.0"

RUN curl -sLf https://github.com/kubernetes-sigs/cri-tools/releases/download/$CRICTL_VERSION/crictl-${CRICTL_VERSION}-linux-amd64.tar.gz --output crictl-${CRICTL_VERSION}-linux-amd64.tar.gz \
    && tar zxvf crictl-$CRICTL_VERSION-linux-amd64.tar.gz -C /usr/bin \
    && rm -f crictl-$CRICTL_VERSION-linux-amd64.tar.gz

COPY entrypoint.sh /usr/bin/

RUN echo "runtime-endpoint: unix:///var/run/dockershim.sock" > /etc/crictl.yaml \
    && echo "image-endpoint: unix:///var/run/dockershim.sock" >> /etc/crictl.yaml

ENTRYPOINT ["/usr/bin/dumb-init", "--"]

CMD ["entrypoint.sh"]


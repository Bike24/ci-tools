FROM gcr.io/kaniko-project/executor:v1.3.0 AS kaniko

FROM alpine:3.13.0

ENV GCLOUD_SDK_VERSION 324.0.0
ENV HELM_VERSION v3.5.0
ENV KUBECTL_VERSION v1.20.2
ENV KUBEVAL_VERSION 0.15.0
ENV SOPS_VERSION v3.6.1
ENV TERRAFORM_VERSION 0.14.4
ENV YQ_BIN_VERSION v4.4.1

ENV PATH /google-cloud-sdk/bin:$PATH

COPY --from=kaniko /kaniko/executor /usr/local/bin/executor
COPY entrypoint.sh entrypoint.sh
COPY commands.sh /data/commands.sh
COPY install.sh /tmp/install.sh

RUN chmod +x /tmp/install.sh && \
    /tmp/install.sh

VOLUME /data

USER ci-tools

ENTRYPOINT ["/entrypoint.sh"]

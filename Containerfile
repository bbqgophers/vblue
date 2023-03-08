ARG IMAGE_NAME="${IMAGE_NAME:-silverblue}"
ARG SOURCE_IMAGE="${SOURCE_IMAGE:-silverblue}"
ARG BASE_IMAGE="quay.io/fedora-ostree-desktops/${SOURCE_IMAGE}"
ARG FEDORA_MAJOR_VERSION="${FEDORA_MAJOR_VERSION:-37}"

FROM ${BASE_IMAGE}:${FEDORA_MAJOR_VERSION} AS builder

ARG IMAGE_NAME="${IMAGE_NAME}"
ARG FEDORA_MAJOR_VERSION="${FEDORA_MAJOR_VERSION}"

ADD build.sh /tmp/build.sh
ADD post-install.sh /tmp/post-install.sh
ADD packages.json /tmp/packages.json

COPY --from=ghcr.io/ublue-os/config:latest /rpms /tmp/rpms
COPY --from=docker.io/bketelsen/vanilla-os:v0.0.11 /usr/share/backgrounds/vanilla /usr/share/backgrounds/vanilla
COPY --from=docker.io/bketelsen/vanilla-os:v0.0.11 /usr/bin/apx /usr/bin/apx
COPY --from=docker.io/bketelsen/vanilla-os:v0.0.11 /etc/apx/config.json /etc/apx/config.json
COPY --from=docker.io/bketelsen/vanilla-os:v0.0.11 /usr/lib/apx/distrobox /usr/lib/apx/distrobox

RUN /tmp/build.sh
RUN /tmp/post-install.sh
RUN rm -rf /tmp/* /var/*
RUN ostree container commit
RUN mkdir -p /var/tmp && chmod -R 1777 /var/tmp

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
COPY --from=ghcr.io/bketelsen/vanilla-os:v0.0.11 /usr/share/backgrounds/vanilla /usr/share/backgrounds/vanilla
COPY --from=ghcr.io/bketelsen/vanilla-os:v0.0.11 /usr/share/gnome-background-properties/vanilla.xml /usr/share/gnome-background-properties/vanilla.xml
COPY --from=ghcr.io/bketelsen/vanilla-os:v0.0.11 /usr/share/plymouth/themes/vanilla-text /usr/share/plymouth/themes/vanilla-text
COPY --from=ghcr.io/bketelsen/vanilla-os:v0.0.11 /usr/share/plymouth/themes/vanilla-logo /usr/share/plymouth/themes/vanilla-logo
COPY --from=ghcr.io/bketelsen/vanilla-os:v0.0.11 /usr/share/plymouth/themes/vanilla-bgrt /usr/share/plymouth/themes/vanilla-bgrt

RUN /tmp/build.sh
RUN /tmp/post-install.sh
RUN rm -rf /tmp/* /var/*
RUN ostree container commit
RUN mkdir -p /var/tmp && chmod -R 1777 /var/tmp

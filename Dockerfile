# ====================
# ⚙️ build an image from debian bookworm (debian 12)
# ====================
FROM bitnami/minideb:bookworm

SHELL ["/bin/bash", "-o", "errexit", "-o", "nounset", "-o", "pipefail", "-c", "-x"]

ARG STANDARD_PACKAGES="curl ca-certificates"

RUN install_packages ${STANDARD_PACKAGES}

# ✅ copy files
COPY examples.d/ /root/.valet.d/examples.d/
COPY valet.d/ /opt/valet/valet.d/
COPY extras/ /opt/valet/extras/
COPY valet /opt/valet/valet

# ✅ add the valet binary to the path and self config/build
RUN \
printf '%s\n%s "$@"' "#/usr/bin/env bash" "/opt/valet/valet" > /usr/local/bin/valet; \
chmod +x /opt/valet/valet; \
chmod +x /opt/valet/valet/valet.d/commands.d/self-build.sh; \
chmod +x /usr/local/bin/valet; \
valet self config --no-edit --override --export-current-values

# ✅ finalize the image
ENTRYPOINT [ "valet" ]
CMD [ ]

# ====================
# ⚙️ build an image from debian trixie (debian 13)
# ====================
FROM debian:trixie-slim

SHELL ["/bin/bash", "-o", "errexit", "-o", "nounset", "-o", "pipefail", "-c", "-x"]

ARG STANDARD_PACKAGES="curl ca-certificates locales"

# ✅ copy files
COPY showcase.d/ /root/.valet.d/showcase.d/
COPY libraries.d/ /opt/valet/libraries.d/
COPY commands.d/ /opt/valet/commands.d/
COPY extras/ /opt/valet/extras/
COPY valet /opt/valet/valet

# ✅ set up locale
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8
ENV LANGUAGE=C.UTF-8

# ✅ self config + build
# ✅ add the valet binary to the path
RUN \
echo "LANG=C.UTF-8" >> /etc/locale.conf; \
echo -e "#"'!'"/usr/bin/env bash"$'\n'"/opt/valet/valet \"\$@\"" > /usr/local/bin/valet; \
chmod +x /opt/valet/valet; \
chmod +x /opt/valet/commands.d/self-build.sh; \
chmod +x /usr/local/bin/valet; \
export VALET_CONFIG_ENABLE_COLORS=true; \
valet self config --no-edit --override --export-current-values

# ✅ finalize the image
ENTRYPOINT [ "valet" ]
CMD [ ]

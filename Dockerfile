# ====================
# ⚙️ build an image from debian bookworm (debian 12)
# ====================
FROM bitnami/minideb:bookworm

SHELL ["/bin/bash", "-o", "errexit", "-o", "nounset", "-o", "pipefail", "-c", "-x"]

ARG STANDARD_PACKAGES="curl ca-certificates locales"

# ✅ install packages
# ✅ set up locale
ARG LOCALE=C
ENV LANG=${LOCALE}.UTF-8
ENV LC_ALL=${LOCALE}.UTF-8
ENV LANGUAGE=${LOCALE}.UTF-8
RUN \
install_packages ${STANDARD_PACKAGES} ; \
localedef -i ${LOCALE} -c -f UTF-8 -A /usr/share/locale/locale.alias ${LOCALE}.UTF-8; \
echo "${LOCALE}.UTF-8 UTF-8" >> /etc/locale.gen; \
echo "LANG=${LOCALE}.UTF-8" >> /etc/locale.conf; \
locale-gen ${LOCALE}.UTF-8

# ✅ copy files
COPY showcase.d/ /root/.valet.d/showcase.d/
COPY libraries.d/ /opt/valet/libraries.d/
COPY commands.d/ /opt/valet/commands.d/
COPY extras/ /opt/valet/extras/
COPY valet /opt/valet/valet

# ✅ add the valet binary to the path
# ✅ self config + build
RUN \
echo -e "#"'!'"/usr/bin/env bash"$'\n'"/opt/valet/valet \"\$@\"" > /usr/local/bin/valet; \
chmod +x /opt/valet/valet; \
chmod +x /opt/valet/commands.d/self-build.sh; \
chmod +x /usr/local/bin/valet; \
export VALET_CONFIG_ENABLE_COLORS=true; \
valet self config --no-edit --override --export-current-values

# ✅ finalize the image
ENTRYPOINT [ "valet" ]
CMD [ ]

FROM bitnami/minideb:bookworm

SHELL ["/bin/bash", "-o", "errexit", "-o", "nounset", "-o", "pipefail", "-c", "-x"]

ARG STANDARD_PACKAGES="curl ca-certificates locales"

# ✅ install packages
# ✅ set up locale
ARG LOCALE=en_US
ENV LANG=${LOCALE}.UTF-8
RUN \
install_packages ${STANDARD_PACKAGES} ; \
localedef -i ${LOCALE} -c -f UTF-8 -A /usr/share/locale/locale.alias ${LOCALE}.UTF-8; \
echo "LC_ALL=${LOCALE}.UTF-8" >> /etc/environment; \
echo "${LOCALE}.UTF-8 UTF-8" >> /etc/locale.gen; \
echo "LANG=${LOCALE}.UTF-8" >> /etc/locale.conf; \
locale-gen ${LOCALE}.UTF-8

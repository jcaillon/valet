FROM ubuntu:latest

SHELL ["/bin/bash", "-o", "errexit", "-o", "nounset", "-o", "pipefail", "-c", "-x"]

# ✅ install packages
# ✅ set up locale
ARG LOCALE=en_US
ENV LANG=${LOCALE}.UTF-8
RUN \
apt-get update -qq; \
apt-get install -qq -y curl sudo makepasswd uidmap 1>/dev/null; \
echo 'me' > /tmp/pw; \
useradd -m -u 1000 -U -p "$(makepasswd --crypt-md5 --clearfrom=/tmp/pw)" me; \
echo "me ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers.d/me-sudo; \
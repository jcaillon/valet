FROM bitnami/minideb:bookworm

SHELL ["/bin/bash", "-o", "errexit", "-o", "nounset", "-o", "pipefail", "-c", "-x"]

ARG STANDARD_PACKAGES="locales ca-certificates curl sudo makepasswd uidmap git xonsh fish zsh csh tcsh ksh build-essential wget"

# ✅ install packages
# ✅ set up locale
ARG LOCALE=en_US
ENV LANG=${LOCALE}.UTF-8
ENV LC_ALL=${LOCALE}.UTF-8
ENV LANGUAGE=${LOCALE}.UTF-8
RUN \
install_packages ${STANDARD_PACKAGES} ; \
localedef -i ${LOCALE} -c -f UTF-8 -A /usr/share/locale/locale.alias ${LOCALE}.UTF-8; \
echo "${LOCALE}.UTF-8 UTF-8" >> /etc/locale.gen; \
echo "LANG=${LOCALE}.UTF-8" >> /etc/locale.conf; \
locale-gen ${LOCALE}.UTF-8; \
echo 'me' > /tmp/pw; \
useradd -m -u 1000 -U -p "$(makepasswd --crypt-md5 --clearfrom=/tmp/pw)" me; \
echo "me ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers.d/me-sudo; \
chsh -s /bin/bash me; \
curl -fsSL https://github.com/nushell/nushell/releases/download/0.100.0/nu-0.100.0-x86_64-unknown-linux-gnu.tar.gz -o nu.tar.gz; \
tar -xvf nu.tar.gz; \
mv nu-0.100.0-x86_64-unknown-linux-gnu/nu /usr/local/bin/nu;

# ✅ instal delta
RUN \
  pushd /tmp; \
  curl -fsSL https://github.com/dandavison/delta/releases/download/0.18.2/delta-0.18.2-x86_64-unknown-linux-gnu.tar.gz -O; \
  tar -xvf delta-0.18.2-x86_64-unknown-linux-gnu.tar.gz; \
  mv delta-0.18.2-x86_64-unknown-linux-gnu/delta /usr/local/bin/delta; \
  popd; \
  rm -rf /tmp/*

# now install bash 5.0
SHELL ["/bin/sh", "-o", "errexit", "-o", "nounset", "-x", "-c"]

RUN \
cd /tmp; \
wget http://ftp.gnu.org/gnu/bash/bash-5.0.tar.gz; \
tar xf bash-5.0.tar.gz; \
cd bash-5.0; \
./configure; \
make; \
sudo make install; \
rm /bin/bash; \
sudo ln -s /usr/local/bin/bash /bin/bash;
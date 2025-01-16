FROM ubuntu:latest

SHELL ["/bin/bash", "-o", "errexit", "-o", "nounset", "-o", "pipefail", "-c", "-x"]

# ✅ install packages
# ✅ set up locale
ARG LOCALE=en_US
ENV LANG=${LOCALE}.UTF-8
RUN \
apt-get update -qq; \
apt-get install -qq -y curl sudo makepasswd uidmap git xonsh fish zsh csh tcsh ksh build-essential wget 1>/dev/null; \
echo 'me' > /tmp/pw; \
useradd -m -u 1000 -U -p "$(makepasswd --crypt-md5 --clearfrom=/tmp/pw)" me; \
echo "me ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers.d/me-sudo; \
chsh -s /bin/bash me; \
curl -fsSL https://github.com/nushell/nushell/releases/download/0.100.0/nu-0.100.0-x86_64-unknown-linux-gnu.tar.gz -o nu.tar.gz; \
tar -xvf nu.tar.gz; \
mv nu-0.100.0-x86_64-unknown-linux-gnu/nu /usr/local/bin/nu;

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
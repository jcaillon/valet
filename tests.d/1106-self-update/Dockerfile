FROM debian:latest

USER root

SHELL ["/bin/bash", "-o", "errexit", "-o", "nounset", "-o", "pipefail", "-c", "-x"]

# install standard packages
RUN apt-get update -qq && \
  apt-get install -qq -y \
  apt-transport-https \
  apt-utils \
  ca-certificates \
  coreutils \
  curl \
  git \
  sudo \
  uidmap \
  zsh \
  && \
  find /var/log -type f -delete && \
  apt-get clean all && \
  rm -Rf /tmp/*

# create "me" user with "me" password, change the shell, set up local bin
RUN echo 'me' > /tmp/pw && \
  useradd -m -u 1000 -U -p "$(makepasswd --crypt-md5 --clearfrom=/tmp/pw.txt)" me && \
  chsh -s /usr/bin/zsh me && \
  sudo runuser -l me -c 'install -d /home/me/.local/bin'

# make "me" user able to sudo w/o password
# RUN echo "me ALL=(ALL:ALL) ALL" >> /etc/sudoers.d/me-sudo
RUN echo "me ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers.d/me-sudo

USER me
WORKDIR /home/me

RUN export NONINTERACTIVE=1 && \
  export CI=1 && \
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

COPY ./self-install.sh /root
COPY --chown=me:me ./self-install.sh /home/me

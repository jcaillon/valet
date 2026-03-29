FROM debian:trixie AS bash-builder

SHELL ["/bin/bash", "-o", "errexit", "-o", "nounset", "-o", "pipefail", "-c", "-x"]

ARG STANDARD_PACKAGES="locales ca-certificates curl build-essential wget devscripts"

RUN \
  apt-get update; \
  apt-get install -qq -y ${STANDARD_PACKAGES};

# build bash 5.0
RUN \
  cd /tmp; \
  wget http://ftp.gnu.org/gnu/bash/bash-5.0.tar.gz; \
  tar xf bash-5.0.tar.gz; \
  cd bash-5.0; \
  export CFLAGS="-O2 -fpermissive"; \
  ./configure; \
  make; \
  unset -v CFLAGS; \
  cp ./bash /usr/local/bin/bash-5.0; \
  cd /tmp; \
  rm -rf /tmp/*

# build bash 5.1
RUN \
  cd /tmp; \
  wget http://ftp.gnu.org/gnu/bash/bash-5.1.tar.gz; \
  tar xf bash-5.1.tar.gz; \
  cd bash-5.1; \
  export CFLAGS="-g -O2 -Wno-implicit-function-declaration -std=gnu11"; \
  ./configure; \
  make; \
  unset -v CFLAGS; \
  cp ./bash /usr/local/bin/bash-5.1; \
  cd /tmp; \
  rm -rf /tmp/*

# build bash 5.2
RUN \
  cd /tmp; \
  wget http://ftp.gnu.org/gnu/bash/bash-5.2.tar.gz; \
  tar xf bash-5.2.tar.gz; \
  cd bash-5.2; \
  export CFLAGS="-g -O2 -Wno-implicit-function-declaration -std=gnu11"; \
  ./configure; \
  make; \
  unset -v CFLAGS; \
  cp ./bash /usr/local/bin/bash-5.2; \
  cd /tmp; \
  rm -rf /tmp/*

# build bash 5.3
RUN \
  cd /tmp; \
  wget http://ftp.gnu.org/gnu/bash/bash-5.3.tar.gz; \
  tar xf bash-5.3.tar.gz; \
  cd bash-5.3; \
  ./configure; \
  make; \
  cp ./bash /usr/local/bin/bash-5.3; \
  cd /tmp; \
  rm -rf /tmp/*

RUN \
  pushd /tmp; \
  curl -fsSL https://github.com/nushell/nushell/releases/download/0.111.0/nu-0.111.0-x86_64-unknown-linux-gnu.tar.gz -o nu.tar.gz; \
  tar -xvf nu.tar.gz; \
  mv nu-0.111.0-x86_64-unknown-linux-gnu/nu /usr/local/bin/nu; \
  curl -fsSL https://github.com/dandavison/delta/releases/download/0.19.1/delta-0.19.1-x86_64-unknown-linux-gnu.tar.gz -O; \
  tar -xvf delta-0.19.1-x86_64-unknown-linux-gnu.tar.gz; \
  mv delta-0.19.1-x86_64-unknown-linux-gnu/delta /usr/local/bin/delta; \
  popd; \
  rm -rf /tmp/*


FROM debian:trixie-slim

SHELL ["/bin/bash", "-o", "errexit", "-o", "nounset", "-o", "pipefail", "-c", "-x"]

ARG STANDARD_PACKAGES="locales ca-certificates curl git xonsh fish zsh csh tcsh ksh wget"

COPY --from=bash-builder /usr/local/bin /usr/local/bin

# ✅ install packages
# ✅ set up locale
ARG LOCALE=en_US
ENV LANG=${LOCALE}.UTF-8
ENV LC_ALL=${LOCALE}.UTF-8
ENV LANGUAGE=${LOCALE}.UTF-8
RUN \
  apt-get update; \
  apt-get install -qq -y ${STANDARD_PACKAGES}; \
  localedef -i ${LOCALE} -c -f UTF-8 -A /usr/share/locale/locale.alias ${LOCALE}.UTF-8; \
  echo "${LOCALE}.UTF-8 UTF-8" >> /etc/locale.gen; \
  echo "LANG=${LOCALE}.UTF-8" >> /etc/locale.conf; \
  locale-gen ${LOCALE}.UTF-8; \
  useradd -m -s /bin/bash me; \
  chmod a+x /usr/local/bin/*;

USER me
WORKDIR /home/me
ENTRYPOINT [ "/bin/bash" ]
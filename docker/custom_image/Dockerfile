FROM debian:bullseye-slim

ENV DEBIAN_FRONTEND=noninteractive

USER root

# Install sudo
RUN set -x \
  && apt-get update --fix-missing \
  && apt-get install -y sudo

# Create apisix user and add to sudoers
RUN useradd -ms /bin/bash apisix \
  && adduser apisix sudo \
  && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Switch to apisix user
USER apisix

WORKDIR /home/apisix/

# Install dependencies
RUN set -x \
  && sudo apt-get update --fix-missing \
  && sudo apt-get install -y --no-install-recommends \
  wget \
  curl \
  gnupg \
  ca-certificates \
  unzip \
  git \
  make \
  gawk \
  libyaml-dev \
  libldap2-dev \
  liblua5.1-0-dev \
  lua5.1

# Install APISIX from source
ARG GIT_APISIX_BRANCH='master'
ENV APISIX_SOURCE_DIR="/home/apisix/apisix_src"

RUN git clone --depth 1 --branch ${GIT_APISIX_BRANCH} https://github.com/apache/apisix.git ${APISIX_SOURCE_DIR}/ \
  && cd ${APISIX_SOURCE_DIR}/ \
  && make deps \
  && sudo make install

WORKDIR ${APISIX_SOURCE_DIR}

# Install etcd
RUN export ETCD_VERSION='3.5.19' \
  && wget https://github.com/etcd-io/etcd/releases/download/v${ETCD_VERSION}/etcd-v${ETCD_VERSION}-linux-amd64.tar.gz \
  && mkdir ${APISIX_SOURCE_DIR}/etcd/ \
  && tar -xvf etcd-v${ETCD_VERSION}-linux-amd64.tar.gz -C ${APISIX_SOURCE_DIR}/etcd/ --strip-components=1 \
  && rm etcd-v${ETCD_VERSION}-linux-amd64.tar.gz \
  && cd ${APISIX_SOURCE_DIR}/etcd/ \
  && sudo cp -a etcd etcdctl /usr/bin/

# Install test-nginx
RUN curl -L https://cpanmin.us | perl - --sudo App::cpanminus \
  && sudo cpanm --notest Test::Nginx IPC::Run > build.log 2>&1 || (cat build.log && exit 1) \
  && git clone https://github.com/openresty/test-nginx.git ${APISIX_SOURCE_DIR}/test-nginx/ \
  && export PERL5LIB=.:$PERL5LIB

# Install toolkit
RUN git clone https://github.com/api7/test-toolkit ${APISIX_SOURCE_DIR}/t/toolkit/

COPY ./docker_scripts/docker_entrypoint.sh /home/apisix/docker_entrypoint.sh
RUN sudo chown apisix:apisix /home/apisix/docker_entrypoint.sh \
  && sudo chmod +x /home/apisix/docker_entrypoint.sh

COPY ./docker_scripts/run_tests.sh /home/apisix/run_tests.sh
RUN sudo chown apisix:apisix /home/apisix/run_tests.sh \
  && sudo chmod +x /home/apisix/run_tests.sh

EXPOSE 9080 9090 9180 9443

ENTRYPOINT [ "/home/apisix/docker_entrypoint.sh" ]

CMD [ "bash" ]

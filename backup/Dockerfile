# syntax=docker/dockerfile:1
FROM ruby:3.1.1

# RUN apt-get update -qq && apt-get install -y nodejs postgresql-client build-essentials 
# Work around encoding issues
# https://hub.docker.com/_/ruby/
ENV LANG C.UTF-8

ENV EDITOR nano

# Install packages
RUN apt-get update -qq && \
  apt-get install -y --no-install-recommends \
  apt-transport-https \
  build-essential \
  cmake \
  imagemagick \
  libffi-dev \
  libjemalloc-dev \
  libmagickwand-dev \
  libpq-dev \
  libsqlite3-dev \
  libvips \
  libvips-dev \
  libvips-tools \
  nano

# install nodejs
# see https://github.com/joyent/docker-node/blob/530696ff3003a169521a61a0e04bbf980b7228d5/0.12/Dockerfile
RUN set -ex \
  && for key in \
    94AE36675C464D64BAFA68DD7434390BDBE9B9C5 \
    FD3A5288F042B6850C66B31F09FE44734EB7990E \
    71DCFD284A79C3B38668286BC97EC7A07EDE3FC1 \
    DD8F2338BAE7501E3DD5AC78C273792F7D83545D \
    C4F0DFFF4E8C1A8236409D08E73BC641CC11F4C8 \
    B9AE9905FFD7803F25714661B63B535A4C206CA9 \
    77984A986EBC2AA786BC0F66B01FBB92821C587A \
    8FCCA13FEF1D0C2E91008E09770F7A9A5AE15600 \
    4ED778F539E3634C779C87C6D7062848A1AB005C \
    A48C2BEE680E841632CD4E44F07496B3EB3C1762 \
    B9E2F5981AA6E0CD28160D9FF13993A75599653C \
  ; do \
    gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$key"; \
  done

ENV NODE_VERSION="12.19.0" YARN_VERSION="1.22.5" PATH="/root/.yarn/bin:${PATH}"
RUN curl -SLO "http://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz" \
  && curl -SLO "http://nodejs.org/dist/v$NODE_VERSION/SHASUMS256.txt.asc" \
  && gpg --verify SHASUMS256.txt.asc \
  && grep " node-v$NODE_VERSION-linux-x64.tar.gz\$" SHASUMS256.txt.asc | sha256sum -c - \
  && tar -xzf "node-v$NODE_VERSION-linux-x64.tar.gz" -C /usr/local --strip-components=1 \
  && rm "node-v$NODE_VERSION-linux-x64.tar.gz" SHASUMS256.txt.asc \
  && curl -o- -L https://yarnpkg.com/install.sh | bash -s -- --version $YARN_VERSION

# Install Chrome
#RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
#  && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
#  && apt-get update \
#  && apt-get install -y google-chrome-stable --no-install-recommends \
#  && apt-get clean \
#  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /src/*.deb \
#  && truncate -s 0 /var/log/*log


WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install


# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]
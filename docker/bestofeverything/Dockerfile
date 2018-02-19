FROM amazonlinux

RUN yum -y update
RUN yum -y upgrade
RUN yum -y install git gcc-c++ make nodejs ImageMagick-devel ImageMagick-c++-devel zip tmux wget curl which perl python ruby-devel gcc

# Set working directory.
ENV HOME /root
WORKDIR /root

# setup RVM
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
RUN \curl -sSL https://get.rvm.io | bash -s stable --ruby
RUN source /usr/local/rvm/scripts/rvm
RUN /bin/bash -l -c "rvm install '2.3.0'"
RUN /bin/bash -l -c "rvm --default use 2.3.0"
RUN /bin/bash -l -c "gem install bundler jekyll"

# install nodebrew
RUN wget git.io/nodebrew
RUN perl nodebrew setup
ENV PATH $HOME/.nodebrew/current/bin:$PATH
RUN echo 'export PATH=$HOME/.nodebrew/current/bin:$PATH' >> $HOME/.bashrc
RUN nodebrew install-binary v6.12.3
RUN nodebrew use v6.12.3
RUN /bin/bash -l -c "cd $(npm root -g)/npm && npm install fs-extra && sed -i -e s/graceful-fs/fs-extra/ -e s/fs\.rename/fs.move/ ./lib/utils/rename.js && npm -g update npm"
RUN /bin/bash -l -c "npm install --global gatsby-cli"


# RUN mkdir /tmp_build
# COPY ./Gemfile /tmp_build/Gemfile
# COPY ./Gemfile.lock /tmp_build/Gemfinpnle.lock
# WORKDIR /tmp_build
# RUN /bin/bash -l -c "rvm --default use 1.9.3 && gem install bundler && bundle install"
# RUN /bin/bash -l -c "nodebrew use v0.12.7 && npm install"

COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

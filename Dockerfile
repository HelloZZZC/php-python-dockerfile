FROM leou/php-amqp:1.0.0

MAINTAINER zhangchen zc19940702@gmail.com

SHELL ["/bin/bash", "-c"]

# 安装python3的环境
RUN set -ex \
    && apt-get update \
    && apt-get install -y sudo \
    && sudo apt-get install -y \
        gcc \
        g++ \
        build-essential \
        zlib1g-dev \
        libncurses5-dev \
        libgdbm-dev \
        libnss3-dev \
        libssl-dev \
        libreadline-dev \
        libffi-dev \
        wget \
        make \
        xz-utils \
    && wget https://www.python.org/ftp/python/3.7.4/Python-3.7.4.tar.xz \
    && tar -xf Python-3.7.4.tar.xz \
    && cd Python-3.7.4 \
    && ./configure --enable-optimizations \
    && make -j 2 \
    && sudo make altinstall \
    && sudo apt-get install -y python3-pip

# 安装爬虫虚拟环境
RUN set -ex \
    && pip3 install --default-timeout=1000 virtualenv

# 创建python虚拟环境目录
RUN set -ex \
    && mkdir -p /var/www \
    && cd /var/www \
    && virtualenv -p /usr/local/bin/python3.7 python3.7 \
    && cd python3.7 \
    && source bin/activate

# 安装python项目依赖包
RUN set -ex \
    && pip3 install --default-timeout=1000 scrapy \
    && pip3 uninstall -y pyOpenSSL \
    && pip3 install --default-timeout=1000 pyOpenSSL \
    && pip3 install --default-timeout=1000 simplejson \
    && pip3 install --default-timeout=1000 requests \
    && pip3 install --default-timeout=1000 beautifulsoup4 \
    && pip3 install --default-timeout=1000 scrapy-splash

WORKDIR /var/www/python3.7



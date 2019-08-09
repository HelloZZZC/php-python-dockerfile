FROM leou/php-amqp:1.0.0

MAINTAINER zhangchen zc19940702@gmail.com

SHELL ["/bin/bash", "-c"]

# 安装python3的环境
RUN set -ex \
    && apt-get update \
    && apt-get install -y sudo \
    && sudo apt-get install -y wget \
    && sudo apt-get install -y gnupg \
    && sudo apt-get install -y software-properties-common \
    && sudo apt-get install -y ca-certificates wget \
    && sudo apt-key adv --recv-keys --keyserver keyserver.ubuntu.com F23C5A6CF475977595C89F51BA6932366A755776 \
    && sudo add-apt-repository ppa:deadsnakes/ppa \
    && sudo apt-get install -y python3.7 \
    && sudo apt-get install -y python3-pip

# 安装爬虫虚拟环境
RUN set -ex \
    && pip3 install virtualenv

# 创建python虚拟环境目录
RUN set -ex \
    && mkdir -p /var/www \
    && cd /var/www \
    && virtualenv -p /usr/bin/python3.7 python3.7 \
    && cd python3.7 \
    && source bin/activate

# 安装python项目依赖包
RUN set -ex \
    && pip3 install scrapy \
    && pip3 install simplejson \
    && pip3 install requests \
    && pip3 install beautifulsoup4 \
    && pip3 install scrapy-splash

WORKDIR /var/www/python3.7

CMD ["source", "bin/activate"]

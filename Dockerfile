FROM opensuse
MAINTAINER c2j
RUN zypper --non-interactive install python2.7 python-flup python-imaging \
   python-mysqldb python-setuptools sqlite3 dnsmasq \
   python-memcache wget

RUN mkdir /opt/seafile
VOLUME /opt/seafile
EXPOSE 10001 12001 8000 8080 8082

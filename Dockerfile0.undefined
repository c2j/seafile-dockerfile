FROM opensuse
MAINTAINER c2j
RUN zypper --non-interactive install git-core cmake gcc bison flex readline-devel zlib-devel libopenssl-devel
RUN mkdir /src; cd /src; env GIT_SSL_NO_VERIFY=true git clone https://github.com/postgres/postgres.git; cd postgres; git checkout REL9_5_STABLE
ENV PG_HOME /opt/local/postgresql
RUN cd /src/postgres; ./configure --prefix=$PG_HOME --enable-thread-safety --with-wal-blocksize=64 --with-wal-segsize=64 --with-blocksize=32 --with-segsize=2 --enable-debug --with-openssl --without-ldap --with-perl; make; make install

RUN userdel postgres ;\
    groupdel postgres ;\
    /usr/sbin/groupadd postgres ;\
    useradd -g postgres -d /home/postgres -m postgres ;\
    mkdir -p /data/PGDATA ;\
    chown postgres:postgres /data/PGDATA
USER postgres
RUN export PATH=$PG_HOME/bin:$PATH ;\
    export LD_LIBRARY_PATH=$PG_HOME/lib ;\
    initdb -D /data/PGDATA/pgsql
#COPY ./data/PGDATA/pgsql/postgresql.conf /data/PGDATA/pgsql/postgresql.conf
#COPY ./data/PGDATA/pgsql/pg_hba.conf /data/PGDATA/pgsql/pg_hba.conf
#USER root
#RUN chown postgres:postgres /data/PGDATA/pgsql/postgresql.conf /data/PGDATA/pgsql/pg_hba.conf
EXPOSE 5432
#USER postgres 
ENV PATH $PG_HOME/bin
ENV LD_LIBRARY_PATH $PG_HOME/lib
#ENTRYPOINT ["ls", "-l", "/data/PGDATA/pgsql"]
ENTRYPOINT ["postgres", "-D", "/data/PGDATA/pgsql" ]

FROM registry.access.redhat.com/rhel7


RUN yum --disablerepo='*' --enablerepo=rhel-7-server-rpms --enablerepo=rhel-7-server-extras-rpms update -y && \
    yum --disablerepo='*' --enablerepo=rhel-7-server-rpms --enablerepo=rhel-7-server-extras-rpms install -y hostname net-tools psmisc mariadb-server mariadb && yum clean all

ADD ./config_mariadb.sh /config_mariadb.sh

RUN user=mysql new_uid=1002 old_uid=$(id -u $user) && \
    group=mysql new_gid=1002 old_gid=$(id -g $user) && \
    usermod -u $new_uid $user && \
    groupmod -g $new_gid $group && \
    chownlist=$(mktemp) && \
    chgrplist=$(mktemp) && \
    find / \
    \( \( -path "/proc" -or -path "/sys" -or -path "/dev" \) -prune \) -or \
    \( \( -user $old_uid -fprint0 "$chownlist" \) , \
    \( -group $old_gid -fprint0 "$chgrplist" \) \) && \
    cat "$chownlist" | xargs -0 chown $user && \
    cat "$chgrplist" | xargs -0 chown :$group && \
    rm -f "$chownlist" "$chgrplist" && \
    sed -i '/\[mysqld\]/auser=1002' /etc/my.cnf.d/server.cnf

RUN chmod 755 /config_mariadb.sh
RUN /config_mariadb.sh
RUN chmod 777 -R /var/lib/mysql

EXPOSE 3306
USER 1002

CMD ["/usr/bin/mysqld_safe"]

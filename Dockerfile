FROM wathehack/alpine-mini

COPY qemu-arm-static /usr/bin/qemu-arm-static

RUN apk add --update openldap openldap-back-bdb openldap-back-hdb openldap-clients && \
    rm -rf /var/cache/apk/*

ADD slapd.conf /etc/openldap/slapd.conf
ENV LDAPCONF /etc/openldap/slapd.conf
ADD modules /etc/openldap/modules
ADD entrypoint.sh /ep.sh

VOLUME ["/var/lib/openldap"]

EXPOSE 389

#ENTRYPOINT ["/ep.sh" ]
ENTRYPOINT /ep.sh && slapd -u ldap -g ldap -d 32768

#CMD ["slapd", "-u", "ldap", "-g", "ldap", "-d", "32768"]

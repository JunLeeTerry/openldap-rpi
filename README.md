==========
=OpenLDAP=
==========

To build the image for OpenLDAP service, run the command in the directory
containing Dockerfile for OpenLDAP:

    docker build -t openldap .

The most simple form would be to start the application like so (however this is
not the recommended way - see below):

    docker run -d -p 5000:389 -e SLAPD_PASSWORD="password" -e SLAPD_DOMAIN="example.net" --restart=always openldap

To get the full potential this image offers, one should first create a data-only
container (see "Data persistence" below), start the OpenLDAP daemon as follows:

    docker run -d -name openldap --volumes-from your-data-container openldap

An application talking to OpenLDAP should then `--link` the container:

    docker run -d --link openldap:openldap image-using-openldap


Configuration
-------------

For the first run, one has to set at least two environment variables. The first

    SLAPD_PASSWORD

sets the password for the `admin` user.

The second

    SLAPD_DOMAIN

sets the DC (Domain component) parts. E.g. if one sets it to `ldap.example.net`,
the generated base DC parts would be `ldap.example.net`.


Data persistence
----------------

The image exposes two directories (`VOLUME ["/var/lib/openldap"]`).
The first holds the "static" configuration while the second holds the actual
database. Please make sure that these two directories are saved (in a data-only
container or alike) in order to make sure that everything is restored after a
restart of the container.

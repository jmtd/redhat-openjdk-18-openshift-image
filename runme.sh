#!/bin/sh

# XXX: this will be executed by the run harness instead of direct
# eventually
bash /opt/jboss/trust-ose-cert.sh 

/usr/bin/openssl verify \
    /tmp/testcert/testcert.pem

# "unable to ..." = not working
# "certificate expired" = working

# p11-kit,  pkcs11.conf

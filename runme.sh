#!/bin/sh

cp /var/run/secrets/kubernetes.io/serviceaccount/service-ca.crt \
	/etc/pki/ca-trust/source/anchors/
stat /etc/pki/ca-trust/source/anchors/
update-ca-trust

/usr/bin/openssl verify \
    /tmp/testcert/testcert.pem

# "unable to ..." = not working
# "certificate expired" = working

# p11-kit,  pkcs11.conf

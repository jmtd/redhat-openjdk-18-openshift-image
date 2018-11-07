#!/bin/sh

# XXX: this is executed by the s2i shared script, but unless we
# invoke the image via s2i we need to run it manually
bash -x /opt/jboss/container/java/certs/trust-ose-cert.sh

# "unable to ..." = not working
# "certificate expired" = working
if which openssl; then
	openssl verify /tmp/testcert/testcert.pem
fi

# prove the jave keystore is also updated
# you will want to change the hostname to a HTTPS service using a cert
# signed by the CA you have injected into the container via test.sh
# hint: use the company internal CA cert and some internal web service
if ! test -f VerifyHTTPSCert.class; then
	javac VerifyHTTPSCert.java
fi
java VerifyHTTPSCert https://www.google.com/ && echo OK

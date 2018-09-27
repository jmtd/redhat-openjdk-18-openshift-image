# build temp "jmtd" image
# XXX these steps to move out to cct_module once refined

FROM redhat-openjdk-18/openjdk18-openshift
USER 0
# doesn't work
#RUN chown jboss /etc/pki/ca-trust/source

RUN chown jboss \
	/etc/pki/ca-trust/extracted/openssl \
	/etc/pki/ca-trust/extracted/java \
	/etc/pki/ca-trust/source/anchors \
	/etc/pki/ca-trust/extracted/pem
	#/etc/pki/ca-trust/extracted/openssl/ca-bundle.trust.crt \
	#/etc/pki/ca-trust/extracted/pem/tls-ca-bundle.pem \
	#/etc/pki/ca-trust/extracted/pem/email-ca-bundle.pem \
	#/etc/pki/ca-trust/extracted/pem/objsign-ca-bundle.pem \
	#/etc/pki/ca-trust/extracted/java/cacerts \

USER jboss

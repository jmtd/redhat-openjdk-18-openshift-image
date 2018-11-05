uid=$RANDOM
if [ $# -gt 0 ]; then
	uid=$1
fi
echo using uid $uid

docker run --rm -ti \
    -u $uid \
    -v $(pwd)/testcert/ca/ca.cert.pem:/var/run/secrets/kubernetes.io/serviceaccount/service-ca.crt \
    -v $(pwd)/testcert:/tmp/testcert:Z \
    -v $(pwd)/runme.sh:/tmp/runme.sh:Z \
    redhat-openjdk-18/openjdk18-openshift:1.6 \
    /tmp/runme.sh

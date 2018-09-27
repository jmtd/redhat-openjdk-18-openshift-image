    #-u root \
docker run --rm -ti \
    -v $(pwd)/testcert/ca/ca.cert.pem:/var/run/secrets/kubernetes.io/serviceaccount/service-ca.crt \
    -v $(pwd)/testcert:/tmp/testcert \
    -v $(pwd)/runme.sh:/tmp/runme.sh \
    jmtd \
    /tmp/runme.sh
    #redhat-openjdk-18/openjdk18-openshift \

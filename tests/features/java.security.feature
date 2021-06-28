@openjdk
@ubi8/openjdk-8
@ubi8/openjdk-11
@redhat-openjdk-18
Feature: Openshift S2I tests
  Scenario: Check networkaddress.cache.negative.ttl has been set correctly
    Given s2i build https://github.com/jboss-openshift/openshift-examples/ from binary-cli-security-property
    Then s2i build log should contain networkaddress.cache.negative.ttl=0

  @wip
  @ubi8/openjdk-8-runtime
  @ubi8/openjdk-11-runtime
  Scenario: Check networkaddress.cache.negative.ttl has been set correctly RUNTIME
        Given container is started with command /usr/bin/cat
        Then  copy ../../TestDNSCaching.class to /home/jboss in container
        And   run /usr/bin/java TestDNSCaching in container and immediately check its output for networkaddress.cache.negative.ttl=0

#!/usr/bin/env bash
set -euo pipefail

die()
{
    echo "$@"
    exit 1
}

for dep in cekit python3 asciidoctor; do
    if ! which "$dep"; then
        die "$dep is required to execute this script"
    fi
done

mkdir -p docs

# OpenJDK 1.8 / RHEL 7
cekit --redhat --descriptor image.yaml build --dry-run podman
python3 ./gendocs.py "Red Hat 7 with OpenJDK 8"\
    | asciidoctor -o docs/openjdk18-openshift.html -

# OpenJDK 11  / RHEL 7
cekit --redhat --descriptor openjdk-11-rhel7.yaml build --dry-run podman
python3 ./gendocs.py "Red Hat 7 with OpenJDK 11"\
    | asciidoctor -o docs/openjdk-11-rhel7.html -

# OpenJDK 1.8 / UBI 8
cekit --redhat --descriptor ubi8-openjdk-8.yaml build --dry-run podman
python3 ./gendocs.py "Red Hat UBI 8.2 with OpenJDK 8"\
    | asciidoctor -o docs/ubi8-openjdk-8.html -

# OpenJDK 11  / UBI 8
cekit --redhat --descriptor ubi8-openjdk-11.yaml build --dry-run podman
python3 ./gendocs.py "Red Hat UBI 8.2 with OpenJDK 11"\
    | asciidoctor -o docs/ubi8-openjdk-11.html -

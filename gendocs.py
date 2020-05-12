#!/usr/bin/env python3

# read in all the module YAML files specified for an image, in order, to
# produce a comprehensive list of configuration environment variables,
# then write them out to something useful

import yaml

def getvars():
    y = yaml.safe_load(open("target/image.yaml","r"))
    es = {}

    for mobj in y['modules']['install']:
        mname = mobj['name']
        mf = open("target/image/modules/{}/module.yaml".format(mname))
        my = yaml.safe_load(mf)
        for h in my['envs']:
            es[h['name']] = h

    es2 = list(es.values())
    es2.sort(key=(lambda h: h['name']))
    return es2

def adocpreamble():
    print("= Red Hat UBI OpenJDK Image")
    print("Jonathan Dowland <jdowland@redhat.com>")
    print(":toc: left")
    print()

def adoctable(es,ty,test, field):
    print("== {} variables".format(ty))
    print(".Table {} variables".format(ty))
    print("|===")
    print("|Name |{}{} |Description".format(field[0].upper(),field[1:]))
    for h in es:
        if test(h):
            print("|{}".format(h['name']))
            print("|`{}`".format(h.get(field,'-')))
            print("|{}".format(h.get('description','-')))
    print("|===")
    print()

def main():
    es = getvars()
    adocpreamble()
    adoctable(es,"Informational",lambda h: 'value' in h, 'value')
    adoctable(es,"Configuration",lambda h: 'value' not in h, 'example')

if __name__ == "__main__":
    main()

#!/usr/bin/env python3

import os
import sys
import yaml
import re

envs = {} # a dict of dicts, name:{value,example,description}

mods = os.listdir("target/image/modules")
# hack for S2I_SOURCE_DEPLOYMENTS_FILTER being defined in multiple places.
# the definition in this file has the most keys. Proper fix: delete the other
# refs.
mods.append("jboss.container.s2i.core.api")

for d in mods:
    m = "target/image/modules/{}/module.yaml".format(d)
    y = yaml.safe_load(open(m,'r'))
    if 'envs' in y.keys():
        for e in y['envs']:
            n = e['name']
            if n in envs.keys():
                sys.stderr.write("warning: variable {} redefined\n".format(n))
            envs[n] = e

# there will be some duplicates
#print(envs)

#for d in envs:
    #print(d.keys())
    #print("|{}".format(d['name']))
    #if 'description' in d.keys():
    #    print("|{}".format(d['description']))
    #else:
    #    sys.stderr.write("{} lacks description\n".format(d['name']))
    #if 'example' in d.keys():
    #    print("|{}".format(d['example']))
    #else:
    #    sys.stderr.write("{} lacks example\n".format(d['name']))

keypairs = [
    (['description', 'example', 'name', 'value']), # 2
    (['description', 'name', 'value']),            # 4
    (['description', 'name']),                     # 12
    (['name', 'value']),                           # 21
    (['description', 'example', 'name']),          # 81
]

#for d in envs:
    #print("{}: {}".format(d.keys(), d['name']))

#for pair in keypairs:
#    print("\n## {}".format(pair))
#    print("\n")
#    for d in envs:
#        if list(d.keys()) == pair:
#            print(d['name'])

#sys.exit(0)

print("== Configuration environment variables")

print("""|===
|Variable Name |Description |Example Value
""")

i = 0
a = list(envs.keys())
a.sort()
for k in a:
    d = envs[k]
    if 'value' in d.keys():
        continue
    if re.match('.*deprecated', d.get('description','-'), re.IGNORECASE):
        continue
    if 'JAVA_OPTIONS' == d['name']: # deprecated but not marked as such
        continue

    i+=1

    print("|{}".format(d['name']))
    print("|{}".format(d.get('description','-')))
    print("|{}".format(d.get('example','-')))
    print("")

print("|===")
sys.stderr.write("{} configuration Environment Variables\n".format(i))

print("== Environment variables with default values")

print("""|===
|Variable Name |Description |Value
""")

i = 0
for k in a:
    d = envs[k]
    if not 'value' in d.keys() or not 'description' in d.keys():
        continue
    if re.match('.*deprecated', d.get('description','-'), re.IGNORECASE):
        continue

    # hack for the sole informational variable with a description
    if 'JOLOKIA_VERSION' == d['name']:
        continue

    i+=1

    # TODO: 2 keys have a example field too (S2I_SOURCE_DEPLOYMENTS_FILTER, JAVA_DATA_DIR)
    print("|{}".format(d['name']))
    print("|{}".format(d.get('description','-')))
    print("|{}".format(d.get('value','-')))
    print("")

print("|===")
sys.stderr.write("{} Environment Variables with default values\n".format(i))

print("== Information Environment Variables")

print("""|===
|Variable Name |Value
""")

i = 0
for k in a:
    d = envs[k]
    if 'JOLOKIA_VERSION' != d['name']:
        if not 'value' in d.keys() or 'description' in d.keys():
            continue
        if re.match('.*_MODULE$', d['name']):
            continue # paths for cct_module files. Not interesting

    i+=1
    print("|{}".format(d['name']))
    print("|{}".format(d.get('value','-')))
    print("")

print("|===")
sys.stderr.write("{} Information Environment values\n".format(i))

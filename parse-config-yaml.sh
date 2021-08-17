#!/usr/bin/env python

import yaml
import os

with open('config.yaml') as f:
    my_dict = yaml.safe_load(f)
    environment = my_dict['environment'];
    for k, v in environment.items():
      if os.environ.get(k) == None or os.environ.get(k) == '':
        print "%s='%s' export %s;" % (k, v, k)

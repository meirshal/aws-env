#!/usr/bin/env python

import yaml
import os
import sys

my_dict = yaml.safe_load(sys.stdin)
environment = my_dict['environment'];
for k, v in environment.items():
  if os.environ.get(k) == None or os.environ.get(k) == '':
    print "%s='%s' \n" % (k, v)

#!/usr/bin/env python

import json
import pipes
import sys
import os

for k, v in json.load(sys.stdin).items():
    k = pipes.quote(k)
    v = pipes.quote(v)
    if os.environ.get(k) == None or os.environ.get(k) == '':
      print "%s=%s \n" % (k, v)

#!/usr/bin/python

import sys
import math
import numpy as np
import scipy as np
import dataimporter as di

filename = sys.argv[1]
data = di.readCsv(filename, ' ')

print data
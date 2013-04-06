#!/usr/bin/python
# based on http://books.google.de/books?id=cn3JtP5ugQsC&lpg=PA141&ots=YHV9PQJB9v&dq=varianz%20von%20%20zusammengefasste%20gruppen%20formel&hl=de&pg=PA141#v=onepage&q&f=false

import sys
import numpy as np
import dataimporter as di

def aggregate(data):
	k = len(data)
	
#	Define variables needed for formula

	x_array = []
	n_array = []
	
	for i in data:
		x_array.append(float(i[0]))
		n_array.append(int(i[2]))

	x_bar = np.mean(x_array)
	n = float(np.sum(n_array))
	
#	Perform calculation
#	First summand s1

	s1_array = []

	for s1 in data:
		result1 = float(s1[2]) / n * float(s1[1]) * float(s1[1])
		s1_array.append(result1)
		
	s1_sum = np.sum(s1_array)

#	Second summand s2

	s2_array = []
	
	for s2 in data:
		result2 = float(s2[2]) / n * (float(s2[0]) - x_bar) * (float(s2[0]) - x_bar)
		s2_array.append(result2)
		
	s2_sum = np.sum(s2_array)
	
	var = s1_sum + s2_sum
	sd = np.sqrt(var)
	sem = sd / np.sqrt(k)
	
	print x_bar, sd, sem, n, k

# 	Input: List in format: Mean SD NumberOfMeasurements
#	Output: Aggregated Mean, SD, SEM, n, N

filename = sys.argv[1]
data = di.readCsv(filename, ' ')

aggregate(data)
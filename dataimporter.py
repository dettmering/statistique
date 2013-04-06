#!/usr/bin/python

import sys
import csv
import xlrd

def readCsv(filename, delim):	# Reads csv file into an array which will then be used for all searches and calculations. Might be a problem with very large DefaultOut_Image.csv files, tested it with 100 MB
	ifile  = open(filename, "rb")
	reader = csv.reader(ifile, delimiter=delim)
	
	rownum = 0	
	data = []

	for row in reader:
		data.append(row)
		rownum += 1
	ifile.close()
	
	return data

def readXls(filename, worksheet, row_start, col_start):

	wb = xlrd.open_workbook(filename)
	sh = wb.sheet_by_index(worksheet)

	row_end = sh.nrows

	data = []

	while (row_start < row_end):
		data_row = []
		data_br = []
		col_end = sh.ncols

		data_row.append(sh.cell(row_start,0).value)	#Animal
		data_row.append(sh.cell(row_start,4).value)	#Dose
		data_row.append(sh.cell(row_start,7).value)	#Volume
	
		while (col_start < col_end):
			x = []
			if (sh.cell(row_start,col_start).value != ''):
				x.append(sh.cell(row_start,col_start).value)	# Score
				data_br.append(x)
			col_start += 1

		data_row.append(data_br)
		data.append(data_row)
		row_start += 1

	return data
#!/usr/bin/python

#open the file.
fname = raw_input('Enter the file name: ')
try:
	fhand = open(fname)
except:
	print 'File cannot be opened:', fname
	exit()

count = 0
flag = 0
x = []
y = []

#read in.
fileoutput = fname + '.txt'
fout = open(fileoutput,'w')
for line in fhand:
	data = line.split()
	if data == []:
		if flag == 0:
			num = count
			flag = 1
		continue;
	x.append(float (data[0]))
	y.append(float (data[1]))
	count = count + 1
print 'There were', count,num, 'lines in', fname

## rip the 0.0 column out.
loop = count / num
iflag = 0
for index in range(0, loop):
	temp = 0.0
	for index2 in range(0, num):
		temp = temp + y[index2 + index * num]
	if  ( temp < 0.001 and temp > -0.001):
		iflag = index;
		break;
if iflag != 0:
	for index2 in range(0, num):
		y.pop(index2 + iflag * num)
		x.pop(index2 + iflag * num)
	loop = loop - 1

## here is to print the data.
for index in range(0, num):
	temp = []
	for index2 in range(0, loop):
		temp.append(x[index2*num + index])
		temp.append(y[index2*num + index])
	for i in range(0, 2* loop ):
		fout.write( '%f  ' %temp[i])
	fout.write('\n')
	#print temp

fhand.close()
fout.close()

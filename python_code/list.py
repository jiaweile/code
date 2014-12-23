#!/usr/bin/python

t = ['a', 'b', 'c', 'd', 'e', 'f']
print t
del t[1:4]
print t
t.remove('f')
print t

nums = [3, 41, 12, 9, 74, 15]

print "length is %d" %len(nums)
print "max number is: %d " % max(nums)
print "min number is  %d " % min(nums)
print "sum of the numbers: %d" % sum(nums)
print "average of the list: %d " % (sum(nums)/len(nums))


s = 'pining for the fjords'
t = s.split()
print t

s = 'spam-spam-spam'
delimiter = '-'
t = s.split(delimiter)
print t

delimiter = ' take \n'
s = delimiter.join(t)
print s

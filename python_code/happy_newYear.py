#!/usr/bin/python

friends = ['Joseph', 'Glenn', 'Sally']
for friend in friends:
    print 'Happy New Year:', friend
print "Done!"

camels = 42

print "I have spotted %d cammels" % camels
print "In %d years I have spotted %g %s." % (3, 0.1, 'camels')

fhand = open('mbox-short.txt')
for line in fhand:
    if line.startswith('From') :
	line = line.rstrip()
        print line

fhand.close()

while True:
    line = raw_input('> ')
    if line.startswith('#') :
        continue
    if line == 'done':
        break
    print line

print 'Done!'

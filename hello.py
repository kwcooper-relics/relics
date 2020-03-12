from random import random

print 'program start'
def binary_sim(times):

	eight_bit = []
	eight_count = 0
	eight_nice = ' '
	while times > 0:
		print rand
		# print 'times = ' + str(times)
		while eight_count < 9:
			print str(rand) + ' 2'
			if rand > .5:
				eight_bit.append('1')
			else:
				eight_bit.append('0')
			eight_count += 1
			if eight_count > 8:
				eight_bit.append(' ')
			# print 'eight count = ' + str(eight_count)
		for num in eight_bit:
			eight_nice += str(num)
		# print 'before times - 1'
		print eight_nice + '.'
		# print 'times = ' + str(times)
		times = times - 1
binary_sim(3)po



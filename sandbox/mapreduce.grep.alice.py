import multiprocessing.dummy
import re
p = multiprocessing.dummy.Pool(6)
file_handler = open("alice.txt")
x = file_handler.read().split('\n')

def mapper(s): # string -> [(key value)]
	single_space = ' '
	no_space = ' '
	pairs = []
        s = s.replace('\xe2\x80\x94', no_space); s = s.replace('\'', no_space);
        s = re.sub('[:;\t]', single_space, s);
        s = s.lower();
	if s.find('alice') > -1:
		pairs.append((1,s))
	return pairs

def reducer(data):
	pairs = []
        for element in data:
#		print element
		for (key,value) in element:
			if value :
				pairs.append((key,value))
	return pairs

data = map(mapper,x)
data= reducer(data)
print data

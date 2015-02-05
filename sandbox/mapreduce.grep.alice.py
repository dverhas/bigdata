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
        s = re.sub('[.:?!;\t]', single_space, s);
        s = s.lower();
        s = s.split(' ')
	for c in s:
		c = c.strip()
		if(c == '' or c == '"'):
			continue
		pairs.append((c,1))
	return pairs

def combiner(pairs):
	index = {}
	for (key,value) in pairs:
		if not index.has_key(key):
			index[key] = value
		else:
			index[key] = index[key] + value
	pairs = []
	for key in index:
		pairs.append((key,index[key]))
	return pairs

def reducer(data):
	index = {}
	for pairs in data:
		for (key,value) in pairs:
			if not index.has_key(key):
				index[key] = value
			else:
				index[key] = index[key] + value
	pairs = []
	for key in index:
		pairs.append((key,index[key]))
	return pairs

data = p.map(mapper,x)
data = p.map(combiner,data)
sorted_list = reducer(data)
sorted_list.sort(key=lambda word: word[1], reverse=True)
print sorted_list

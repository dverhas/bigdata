
f = open("alice.txt","r")
x = f.read()
x = x.split('\n')
def print_array(array):
	for item in array:
		print item
def mapper(s):
	pairs = []
        space = ' '
        s = s.lower()
        sentance = s.replace(',',space).split(' ')
	for word in sentance :
		for word1 in sentance:
			if word != '' and word1 != '':
                                if word>word1:
					pairs.append((word+word1, 1))
                                else:
					pairs.append((word1+word, 1))
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
		if index[key] > 5:
			pairs.append((key,index[key]))
	return pairs

pairs = map(mapper,x)
pairs = map(combiner,pairs)
pairs = reducer(pairs)
print_array(pairs)

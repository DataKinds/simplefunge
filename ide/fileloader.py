import sys
def normalizeLineLength(scriptList):
	maxLineLength = max(scriptList, key=len)
	for index, line in enumerate(scriptList):
		if len(line) < maxLineLength:
			scriptList[index] += " " * (maxLineLength - len(line))
	return scriptList

def trimFile(scriptList):
	"""
	Takes a split script string with representing a funge program and makes the whitespace properly trimmed
	"""
	if scriptList == []:
		return scriptList
	minTrailingWhitespaceString = min(scriptList, key = lambda l: len(l) - len(l.rstrip()))
	minTrailingWhitespace = len(minTrailingWhitespaceString) - len(minTrailingWhitespaceString.rstrip())
	if minTrailingWhitespace > 0:
		scriptList = [l[:-minTrailingWhitespace] for l in scriptList]
	#horizontally trimmed

	for line in reversed(scriptList):
		if not line[:].strip(): #if it's all whitespace
			scriptList.pop(scriptList.index(line))
		else:
			break
	#vertically trimmed

	return scriptList

def setupPad(mainPad, padX, padY):
	for y in range(0, padY - 1):
		for x in range(0, padX - 1):
			mainPad.addch(y, x, ord(" "))

	scriptList = []
	f = open(sys.argv[1], "r+")
	s = f.read()
	scriptList = trimFile(s.splitlines())
	f.close()
	data = [[" " for _ in range(0, padX)] for y in range(0, padY)] #2d list of singleton lists which contain a char. it's mutable, so shut up
	for y, yList in enumerate(scriptList):
		for x, xChar in enumerate(yList):
			data[y][x] = xChar
			mainPad.addch(y, x, ord(xChar))

	return mainPad, data

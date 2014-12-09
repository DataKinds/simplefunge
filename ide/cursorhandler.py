def safeMoveCursor(stdscr, direction, screenPosition, screenSize, cursorPosition, padX, padY):
	if direction == "up":
		if cursorPosition[0] == 0:
			if screenPosition[0] > 0:
				screenPosition[0] -= 1
		else:
			stdscr.move(cursorPosition[0] - 1, cursorPosition[1])
	elif direction == "down":
		if cursorPosition[0] == screenSize[0] - 1:
			if screenPosition[0] < padY - screenSize[0]:
				screenPosition[0] += 1
		else:
			stdscr.move(cursorPosition[0] + 1, cursorPosition[1])
	elif direction == "left":
		if cursorPosition[1] == 0:
			if screenPosition[1] > 0:
				screenPosition[1] -= 1
		else:
			stdscr.move(cursorPosition[0], cursorPosition[1] - 1)
	elif direction == "right":
		if cursorPosition[1] == screenSize[1] - 1:
			if screenPosition[1] < padX - screenSize[1]:
				screenPosition[1] += 1
		else:
			stdscr.move(cursorPosition[0], cursorPosition[1] + 1)
	return screenPosition

def changeDirection(c, prevDirection):
	if c == "^":
		return "up"
	elif c == "v":
		return "down"
	elif c == "<":
		return "left"
	elif c == ">":
		return "right"
	else:
		return prevDirection



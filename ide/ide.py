from curses import *
from curses import ascii
from cursorhandler import *
from fileloader import *
import sys, os

def isAscii(c):
	return 31 < c < 127

def drawData(mainPad, data):
	trimmedData = trimFile(["".join(d) for d in data])
	for y, yList in enumerate(trimmedData):
		for x, xChar in enumerate(yList):
			mainPad.addch(y, x, ord(xChar))
	return mainPad

def main(stdscr):
	padX = 1000
	padY = 1000
	mainPad = newpad(padX, padY)
	cursorPosition = list(stdscr.getyx())
	direction = "right"
	screenPosition = [0, 0]
	mainPad, data = setupPad(mainPad, padX, padY)

	while True:
		screenSize = stdscr.getmaxyx()
		cursorPosition = list(stdscr.getyx())

		mainPad = drawData(mainPad, data)
		mainPad.refresh(screenPosition[0],screenPosition[1], 0,0, screenSize[0]-1,screenSize[1]-1)

		c = stdscr.getch()
		if c == KEY_UP:
			screenPosition = safeMoveCursor(stdscr, "up", screenPosition, screenSize, cursorPosition, padX, padY)
		elif c == KEY_DOWN:
			screenPosition = safeMoveCursor(stdscr, "down", screenPosition, screenSize, cursorPosition, padX, padY)
		elif c == KEY_LEFT:
			screenPosition = safeMoveCursor(stdscr, "left", screenPosition, screenSize, cursorPosition, padX, padY)
		elif c == KEY_RIGHT:
			screenPosition = safeMoveCursor(stdscr, "right", screenPosition, screenSize, cursorPosition, padX, padY)
		elif c == KEY_BACKSPACE or c == KEY_DL or c == KEY_DC:
			oppDirection = ""
			if direction == "up":
				oppDirection = "down"
			elif direction == "down":
				oppDirection = "up"
			elif direction == "left":
				oppDirection = "right"
			else:
				oppDirection = "left"
			screenPosition = safeMoveCursor(stdscr, oppDirection, screenPosition, screenSize, cursorPosition, padX, padY)
			cursorPosition = list(stdscr.getyx())
			data[cursorPosition[0] + screenPosition[0]][cursorPosition[1] + screenPosition[1]] = " "
		else:
			f = open(sys.argv[1], "w") #MOVE THIS SOMEWHERE ELSE
			f.write("\n".join(trimFile(["".join(d) for d in data])))
			f.close()
			if isAscii(c):
				data[cursorPosition[0] + screenPosition[0]][cursorPosition[1] + screenPosition[1]] = chr(c)
				direction = changeDirection(chr(c), direction)
				screenPosition = safeMoveCursor(stdscr, direction, screenPosition, screenSize, cursorPosition, padX, padY)

if __name__ == "__main__":
	if len(sys.argv) != 2:
		print("Please provide an file as a command line argument.")
		sys.exit()
	wrapper(main)
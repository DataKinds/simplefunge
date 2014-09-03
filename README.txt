- < = move cursor left until a direction change command is encountered

- > = move cursor right until a direction change command is encountered

- ^ = move cursor up until a direction change command is encountered

- v = move cursor down until a direction change command is encountered

- H = move cursor right if top of stack is >0 or left otherwise

- V = move cursor up if top of stack is >0 or down otherwise

- I = input character

- i = input integer

- O = output character

- o = output integer

- 0-9 = push number to top of stack

- + = add numbers on top of stack

- - = subtract numbers on top of stack, going backwards, as in "top - second to top"

- * = multiply numbers on top of stack

- / = divide numbers on top of stack, going backwards, as in "top / second to top"

- ^ = exponent numbers on top of stack, going backwards, as in "second to top ^ top"

- ` =  pop top of stack

- ! = duplicate top of stack (OH GOD THERE ARE TWO OF THEM)

- (space) = continue direction of cursor

- @ = end of program

note: characters get converted to integers on the stack


You only need the simplefunge.rb file unless you have an explicit reason to want the legacy haskell version.

- < = move cursor left until a direction change command is encountered

- > = move cursor right until a direction change command is encountered

- ^ = move cursor up until a direction change command is encountered

- v = move cursor down until a direction change command is encountered

- H = move cursor right if top of stack is >0 or left otherwise

- V = move cursor up if top of stack is >0 or down otherwise

- I = input character

note: characters get converted to integers on the stack

note: this is standard style, it just takes the latest char of all the input to the program

- i = input integer

- O = output character

- o = output integer

- # = output stack for debugging purposes

- n = output newline

- 0-9 = push number to top of stack

- + = add numbers on top of stack

- - = subtract numbers on top of stack, going backwards, as in "top - second to top"

- * = multiply numbers on top of stack

- / = divide numbers on top of stack, going backwards, as in "top / second to top", and places the result on the stack with the top being "divisor", then the next being "remainder"

- ` =  pop top of stack

- ! = duplicate top of stack

- & = switch the top two values on the stack

- | = pop the top of the stack, then move the value from that index to the top - not counting the popped element

- . = pop the top of the stack, then move the next top value to that index - not counting the popped element

note: the top of the stack is index 0

- (space) = continue direction of cursor

- @ = end of program


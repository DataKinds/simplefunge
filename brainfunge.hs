import Parser
import Data.Char

zeroStack :: Stack
zeroStack = repeat 0

getFromArray :: [[a]] -> Coords -> a
getFromArray array (x, y) = (array !! y) !! x

loopCommands :: TwoDimProgram -> Stack -> Coords -> String -> Bool -> IO ()
loopCommands _ _ _ _ True = return ()
loopCommands program stack (x, y) "left" False = commandRun program stack (x-1, y) "left"
loopCommands program stack (x, y) "right" False = commandRun program stack (x+1, y) "right"
loopCommands program stack (x, y) "up" False = commandRun program stack (x, y-1) "up"
loopCommands program stack (x, y) "down" False = commandRun program stack (x, y+1) "down"

commandRun :: TwoDimProgram -> Stack -> Coords -> String -> IO ()
commandRun program stack (x, y) direction
    | program `getFromArray` (x, y) == MoveLeft = loopCommands program stack (x, y) "left" False
    | program `getFromArray` (x, y) == MoveRight = loopCommands program stack (x, y) "right" False
    | program `getFromArray` (x, y) == MoveUp = loopCommands program stack (x, y) "up" False
    | program `getFromArray` (x, y) == MoveDown = loopCommands program stack (x, y) "down" False
--    | program `getFromArray` (x, y) == IfHorizontal = 
--    | program `getFromArray` (x, y) == IfVertical = 
    | program `getFromArray` (x, y) == InputChar = do
        char <- getChar
        loopCommands program ((ord char):stack) (x, y) direction False
    | program `getFromArray` (x, y) == InputInt = do
        
    | program `getFromArray` (x, y) == OutputChar = do
        putStrLn "test"
        loopCommands program stack (x, y) direction False
--    | program `getFromArray` (x, y) == OutputInt = 
--    | program `getFromArray` (x, y) == Add = 
--    | program `getFromArray` (x, y) == Sub = 
--    | program `getFromArray` (x, y) == Mult = 
--    | program `getFromArray` (x, y) == Div = 
--    | program `getFromArray` (x, y) == Exp =  
--    | program `getFromArray` (x, y) == Pop = 
--    | program `getFromArray` (x, y) == Dup = 
--    | program `getFromArray` (x, y) == End = 
--    | program `getFromArray` (x, y) == Noop = 

main = do
    code <- getLine
    commandRun ((charToProgram . programStringToChar) code) (zeroStack) (0, 0) ("left")
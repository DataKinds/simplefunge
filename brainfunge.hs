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
commandRun program stack@(shead:smid:stail) (x, y) direction
    | program `getFromArray` (x, y) == MoveLeft = loopCommands program stack (x, y) "left" False
    | program `getFromArray` (x, y) == MoveRight = loopCommands program stack (x, y) "right" False
    | program `getFromArray` (x, y) == MoveUp = loopCommands program stack (x, y) "up" False
    | program `getFromArray` (x, y) == MoveDown = loopCommands program stack (x, y) "down" False
    | program `getFromArray` (x, y) == IfHorizontal = loopCommands program stack (x, y) (if shead>0 then "right" else "left") False
    | program `getFromArray` (x, y) == IfVertical = loopCommands program stack (x, y) (if shead>0 then "up" else "down") False
    | program `getFromArray` (x, y) == InputChar = do
        char <- getChar
        loopCommands program ((ord char):stack) (x, y) direction False
    | program `getFromArray` (x, y) == InputInt = do
        int <- getLine
        loopCommands program ((read int):stack) (x, y) direction False
    | program `getFromArray` (x, y) == OutputChar = do
        putChar $ chr $ head stack
        loopCommands program stack (x, y) direction False
    | program `getFromArray` (x, y) == OutputInt = do
        putStr $ show $ head stack
        loopCommands program stack (x, y) direction False
    | program `getFromArray` (x, y) == OutputNewline = do
        putStrLn ""
        loopCommands program stack (x, y) direction False
    | program `getFromArray` (x, y) == PushInt = loopCommands program (extractNum (program `getFromArray` (x, y))):stack (x, y) direction False
    | program `getFromArray` (x, y) == Add = loopCommands program ((shead + smid):stail) (x, y) direction False
    | program `getFromArray` (x, y) == Sub = loopCommands program ((shead - smid):stail) (x, y) direction False
    | program `getFromArray` (x, y) == Mult = loopCommands program ((shead * smid):stail) (x, y) direction False
    | program `getFromArray` (x, y) == Div = loopCommands program ((shead / smid):stail) (x, y) direction False
    | program `getFromArray` (x, y) == Exp = loopCommands program ((smid ** shead):stail) (x, y) direction False
    | program `getFromArray` (x, y) == Pop = loopCommands program (smid:stail) (x, y) direction False
    | program `getFromArray` (x, y) == Dup = loopCommands program (shead:shead:smid:stail) (x, y) direction False
    | program `getFromArray` (x, y) == Switch = loopCommands program (smid:shead:stail) (x, y) direction False
    | program `getFromArray` (x, y) == End = loopCommands program stack (x, y) direction True
    | program `getFromArray` (x, y) == Noop = loopCommands program stack (x, y) direction False

main = do
    file <- getLine
    code <- readFile file
    commandRun ((charToProgram . programStringToChar) code) (zeroStack) (0, 0) ("left")
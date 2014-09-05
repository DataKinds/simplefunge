import Parser
import Data.Char
import System.Environment
import System.IO

zeroStack :: Stack
zeroStack = repeat 0

getFromArray :: [[a]] -> Coords -> a
getFromArray array (x, y) = (array !! y) !! x

loopCommands :: TwoDimProgram -> Stack -> Coords -> Directions -> Bool -> IO ()
loopCommands _ _ _ _ True = return ()
loopCommands program stack (x, y) LeftD False = commandRun program stack (x-1, y) LeftD
loopCommands program stack (x, y) RightD False = commandRun program stack (x+1, y) RightD
loopCommands program stack (x, y) UpD False = commandRun program stack (x, y-1) UpD
loopCommands program stack (x, y) DownD False = commandRun program stack (x, y+1) DownD

getCharWithoutNewline :: IO Char
getCharWithoutNewline = do
    c <- getChar
    if c == '\n' then
        getCharWithoutNewline
        else return c

dropFromIndex :: Stack -> Int -> Stack
dropFromIndex stack@(shead:stail) index = (init xs)++ys
    where (xs, ys) = splitAt index stack

splice :: Stack -> Stack
splice stack@(shead:smid:stail) = (st !! fromIntegral shead):(dropFromIndex st (fromIntegral shead))
    where st = smid:stail

commandRun :: TwoDimProgram -> Stack -> Coords -> Directions -> IO ()
commandRun program stack@(shead:smid:stail) (x, y) direction = 
    case program `getFromArray` (x, y) of
    MoveLeft -> loopCommands program stack (x, y) LeftD False
    MoveRight -> loopCommands program stack (x, y) RightD False
    MoveUp -> loopCommands program stack (x, y) UpD False
    MoveDown -> loopCommands program stack (x, y) DownD False
    IfHorizontal -> loopCommands program stack (x, y) (if shead>0 then RightD else LeftD) False
    IfVertical -> loopCommands program stack (x, y) (if shead>0 then UpD else DownD) False
    InputChar -> do
        char <- getCharWithoutNewline
        loopCommands program ((toInteger $ ord char):stack) (x, y) direction False
    InputInt -> do
        int <- getLine
        loopCommands program ((read int):stack) (x, y) direction False
    OutputChar -> do
        putChar $ chr $ fromIntegral $ head stack
        loopCommands program stack (x, y) direction False
    OutputInt -> do
        putStr $ show $ head stack
        hFlush stdout
        loopCommands program stack (x, y) direction False
    OutputNewline -> do
        putStrLn ""
        loopCommands program stack (x, y) direction False
    N0 -> loopCommands program (0:stack) (x, y) direction False
    N1 -> loopCommands program (1:stack) (x, y) direction False
    N2 -> loopCommands program (2:stack) (x, y) direction False
    N3 -> loopCommands program (3:stack) (x, y) direction False
    N4 -> loopCommands program (4:stack) (x, y) direction False
    N5 -> loopCommands program (5:stack) (x, y) direction False
    N6 -> loopCommands program (6:stack) (x, y) direction False
    N7 -> loopCommands program (7:stack) (x, y) direction False
    N8 -> loopCommands program (8:stack) (x, y) direction False
    N9 -> loopCommands program (9:stack) (x, y) direction False
    Add -> loopCommands program ((shead + smid):stail) (x, y) direction False
    Sub -> loopCommands program ((shead - smid):stail) (x, y) direction False
    Mult -> loopCommands program ((shead * smid):stail) (x, y) direction False
    Div -> loopCommands program ((fst (shead `divMod` smid)):(snd (shead `divMod` smid)):stail) (x, y) direction False
    Pop -> loopCommands program (drop 1 stack) (x, y) direction False
    Dup -> loopCommands program (shead:shead:smid:stail) (x, y) direction False
    Switch -> loopCommands program (smid:shead:stail) (x, y) direction False
--    MoveFrom -> loopCommands program (splice stack) (x, y) direction False
    MoveTo -> loopCommands program ((take (fromIntegral shead) stail)++[smid]++(drop (fromIntegral shead) stail)) (x, y) direction False
    End -> loopCommands program stack (x, y) direction True
    Noop -> loopCommands program stack (x, y) direction False

main = do
    file <- getArgs
    code <- readFile $ head file
    commandRun ((charToProgram . programStringToChar) code) (zeroStack) (0, 0) (LeftD)
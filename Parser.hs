module Parser where
    data Commands = MoveLeft |
                    MoveRight |
                    MoveUp |
                    MoveDown |
                    IfVertical |
                    IfHorizontal |
                    InputChar |
                    InputInt |
                    OutputChar |
                    OutputInt |
                    OutputNewline |
                    PushInt Int |
                    Add |
                    Sub |
                    Mult |
                    Div |
                    Exp |
                    Pop |
                    Dup |
                    Noop |
                    End
                    deriving (Show, Eq)

    type Stack = [Int]
    type TwoDimProgramChar = [[Char]]
    type TwoDimProgram = [[Commands]]
    type Coords = (Int, Int)

    programStringToChar :: String -> TwoDimProgramChar
    programStringToChar string = lines string

    charToProgram :: TwoDimProgramChar -> TwoDimProgram
    charToProgram chars = map (map (charToCommand)) chars
        where charToCommand '<' = MoveLeft
              charToCommand '>' = MoveRight
              charToCommand '^' = MoveUp
              charToCommand 'v' = MoveDown
              charToCommand 'H' = IfHorizontal
              charToCommand 'V' = IfVertical
              charToCommand 'I' = InputChar
              charToCommand 'i' = InputInt
              charToCommand 'O' = OutputChar
              charToCommand 'o' = OutputInt
              charToCommand 'n' = OutputNewline
              charToCommand '+' = Add
              charToCommand '-' = Sub
              charToCommand '*' = Mult
              charToCommand '/' = Div
              charToCommand ',' = Exp
              charToCommand '`' = Pop
              charToCommand '!' = Dup
              charToCommand '@' = End
              charToCommand ' ' = Noop
              charToCommand '0' = PushInt 0
              charToCommand '1' = PushInt 1
              charToCommand '2' = PushInt 2
              charToCommand '3' = PushInt 3
              charToCommand '4' = PushInt 4
              charToCommand '5' = PushInt 5
              charToCommand '6' = PushInt 6
              charToCommand '7' = PushInt 7
              charToCommand '8' = PushInt 8
              charToCommand '9' = PushInt 9
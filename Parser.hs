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
                    N0 |
                    N1 |
                    N2 |
                    N3 |
                    N4 |
                    N5 |
                    N6 |
                    N7 |
                    N8 |
                    N9 |
                    Add |
                    Sub |
                    Mult |
                    Div |
                    Pop |
                    Dup |
                    Switch |
                    MoveFrom |
                    MoveTo |
                    Noop |
                    End
                    deriving (Show, Eq)
    data Directions = UpD | DownD | LeftD | RightD

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
              charToCommand '`' = Pop
              charToCommand '!' = Dup
              charToCommand '&' = Switch
              charToCommand '|' = MoveFrom
              charToCommand '.' = MoveTo
              charToCommand '@' = End
              charToCommand ' ' = Noop
              charToCommand '0' = N0
              charToCommand '1' = N1
              charToCommand '2' = N2
              charToCommand '3' = N3
              charToCommand '4' = N4
              charToCommand '5' = N5
              charToCommand '6' = N6
              charToCommand '7' = N7
              charToCommand '8' = N8
              charToCommand '9' = N9
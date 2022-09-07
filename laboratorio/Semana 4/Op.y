{
module Op where
import Data.Char
import Data.List
}

%name parser
%tokentype {Token}
%error {parseError}

%token 
      num             { TokenNum $$ }
      '('             { TokenOB }
      ')'             { TokenCB }
      '+'             { TokenSum }
      '-'             { TokenRes }
      '*'             { TokenMult }
      '/'             { TokenDiv }
      '<'             { TokenLt }
      '>'             { TokenGt }
      equals          { TokenEquals }           
      pred            { TokenPred }
      succ            { TokenSucc }
      sqrt            { TokenSqrt }
      pow             { TokenPow }
      min             { TokenMin }
      max             { TokenMax }
      

%left min max
%nonassoc '>' '<' equals
%left '+' '-'
%left '*' '/'
%left pred succ
%left pow sqrt
%%

Exp   : num                             { NumE $1 }
      | '(' Exp ')'                     { $2 }
      | Exp '+' Exp                     { Sum $1 $3 }
      | Exp '-' Exp                     { Res $1 $3 }
      | Exp '*' Exp                     { Mult $1 $3 }
      | Exp '/' Exp                     { Div $1 $3 }
      | Exp '<' Exp                     { Lt $1 $3 }
      | Exp '>' Exp                     { Gt $1 $3 }
      | min Exp Exp                     { Min $2 $3 }
      | max Exp Exp                     { Max $2 $3 }
      | pow Exp Exp                     { Pow $2 $3 }
      | equals Exp Exp                  { Eq $2 $3 }
      | pred Exp                        { Pred $2 }
      | succ Exp                        { Succ $2 }
      | sqrt Exp                        { Sqrt $2 }

{
parseError :: [Token] -> a
parseError _ = error "Parse error"

data Exp
      = NumE Int
      | Sum Exp Exp
      | Res Exp Exp
      | Mult Exp Exp
      | Div Exp Exp
      | Lt Exp Exp
      | Gt Exp Exp
      | Min Exp Exp
      | Max Exp Exp
      | Pow Exp Exp
      | Eq Exp Exp
      | Pred Exp
      | Succ Exp
      | Sqrt Exp
      deriving Show
 

data Token
      = TokenNum Int
      | TokenOB
      | TokenCB
      | TokenSum
      | TokenRes
      | TokenMult
      | TokenDiv
      | TokenLt
      | TokenGt
      | TokenMin
      | TokenMax
      | TokenPow
      | TokenEquals
      | TokenPred
      | TokenSucc
      | TokenSqrt
      deriving Show

lexer :: String -> [Token]
lexer [] = []
lexer (c:cs) 
      | isSpace c = lexer cs
      | isAlpha c = lexVar (c:cs)
      | isDigit c = lexNum (c:cs)
lexer ('+':cs) = TokenSum : lexer cs
lexer ('-':cs) = TokenRes : lexer cs
lexer ('*':cs) = TokenMult : lexer cs
lexer ('/':cs) = TokenDiv : lexer cs
lexer ('<':cs) = TokenLt : lexer cs
lexer ('>':cs) = TokenGt : lexer cs
lexer ('(':cs) = TokenOB : lexer cs
lexer (')':cs) = TokenCB : lexer cs

lexNum cs = TokenNum (read num) : lexer rest
      where (num,rest) = span isDigit cs

lexVar cs =
   case span isAlpha cs of
      ("min", rest) -> TokenMin : lexer rest
      ("max", rest) -> TokenMax : lexer rest
      ("pow", rest) -> TokenPow : lexer rest
      ("equals", rest) -> TokenEquals : lexer rest
      ("pred", rest) -> TokenPred : lexer rest
      ("succ", rest) -> TokenSucc : lexer rest
      ("sqrt", rest) -> TokenSqrt : lexer rest
      (var,rest)   -> error "WRONG valid Token"

mainInter = getContents >>= print . parser . lexer
}
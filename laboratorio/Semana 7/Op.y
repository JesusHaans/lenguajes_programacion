{
module Op where
import Data.Char
import Data.List
}

%name parser
%tokentype {Token}
%error {parseError}

{--

EJEMPLO DE COMO HAPPY INTERPRETA NUM
En la directiva %token estamos definiendo
los simbolos terminales de nuestro lenguaje
entonces indicamos que "num" es un terminal
y que un TokenNum corresponde a num

#########################################

EJEMPLO AGREGAR EXPRESIONES A UN LENGUAJE
Aqui tomamos como base el lenguaje de operaciones
hecho en la clase 4, y le agregamos expresiones
de tipo if-then-else

En la directiva %token, agregamos los terminales
if, then y else, ligandolos a sus tokens correspondientes
--}
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
      if              { TokenIf }
      then            { TokenThen }
      else            { TokenElse }

{--
EJEMPLO AGREGAR EXPRESIONES A UN LENGUAJE
Definimos la precedencia para else, ya que como explciamos en clase tambien puede
generar expresiones ambiguas

if e1 then e2 else e3 + e4
=> (if e1 then e2 else e3) + e4 
o   if e1 then e2 else (e3 + e4)
--}
%left else
%left min max
%nonassoc '>' '<' equals
%left '+' '-'
%left '*' '/'
%left pred succ
%left pow sqrt    
%%

{--
EJEMPLO DE COMO HAPPY INTERPRETA NUM
En nuestra gramatica, usamos num como parte 
de las producciones de la derecha, si se dan cuenta
en la derecha tenemos un simbolo no terminal (Exp)
y simbolos terminales que definimos arriba.

Aqui igual indicamos que cuando encuentre un terminal num
happy debe construir el asa Num $1, pero num esta ligado
al TokenNum $$, por lo tanto lo que se esta indicando aqui
es que cuando nuestro parser encuentre en la lista de Tokens
un TokenNum -> construya el arbol Num

#########################################

EJEMPLO AGREGAR EXPRESIONES A UN LENGUAJE
Ya que agregamos los terminales, debemos agregar la produccion a 
nuestra gramatica, en este caso la produccion sería

Exp -> if Exp then Exp else Exp

ademas de indicar a que asa corresponderia (If $2 $4 $4)

noten que if, then y else son los terminales que definimos arriba,
y que ademas ya se sabe a que token corresponden
--}
Exp   : num                             { Num $1 }
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
      | if Exp then Exp else Exp        { If $2 $4 $6 }


{
parseError :: [Token] -> a
parseError _ = error "Parse error"

{--
EJEMPLO AGREGAR EXPRESIONES A UN LENGUAJE

Se debe agregar el asa abstracta correspondiente
a la nueva expresion
--}
data Exp
      = Num Int
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
      | Pred  Exp
      | Succ Exp
      | Sqrt Exp
      | If Exp Exp Exp  -- SE AGREGO ESTE
      deriving Show
 
{--
EJEMPLO AGREGAR EXPRESIONES A UN LENGUAJE

Se debe agregar los tokens correspondientes
a los nuevos terminales includios en la nueva expresion
--}
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
      | TokenIf -- SE AGREGO ESTE
      | TokenThen -- SE AGREGO ESTE
      | TokenElse -- SE AGREGO ESTE
      deriving Show

{--
EJEMPLO AGREGAR EXPRESIONES A UN LENGUAJE

Se debe agregar casos al lexer para identificar los terminales (Tokens)
de la nueva expresion
--}
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
      ("if", rest) -> TokenIf : lexer rest -- SE AGREGO ESTE
      ("then", rest) -> TokenThen : lexer rest -- SE AGREGO ESTE
      ("else", rest) -> TokenElse : lexer rest -- SE AGREGO ESTE
      (var,rest)   -> error "WRONG valid Token"

main = getContents >>= print . parser . lexer

{--
EJEMPLO AGREGAR EXPRESIONES A UN LENGUAJE

Ahora nuestro leguaje soporta expresiones como "if 3 then 2 else 4 + 5":

parser $lexer "if 3 then 2 else 4 + 5" = If (Num 3) (Num 2) (Sum (Num 4) (Num 5))
--}

}
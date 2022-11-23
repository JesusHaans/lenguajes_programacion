{
module ParserLT where
import Data.Char
import Data.List

import MinL
}

%name parser
%tokentype {Token}
%error {parseError}

{--
EJEMPLO DE PARSER MINLT
--}

%token 
      num             { TokenNum $$ }
      bool            { TokenBool $$ }
      var             { TokenVar $$ }
      '('             { TokenOB }
      ')'             { TokenCB }
      '+'             { TokenSum }
      '*'             { TokenMult }
      if              { TokenIf }
      then            { TokenThen }
      else            { TokenElse }
      lam             { TokenLam }
      '='             { TokenEq }
      '::'            { TokenDots }
      let             { TokenLet }
      in              { TokenIn }
      end             { TokenEnd }
      Nat             { TokenNat }
      Bool            { TokenBoolean }
      '->'            { TokenArrow }


%left else
%right '=' '->'
%left '+'
%left '*'
%%

Exp   : num                             { Num $1 }
      | bool                            { BT $1 }
      | var                             { Var $1 }
      | '(' Exp ')'                     { $2 }
      | Exp '+' Exp                     { AddT $1 $3 }
      | Exp '*' Exp                     { MultT $1 $3 }
      | if Exp then Exp else Exp        { IfT $2 $4 $6 }
      | let var '=' Exp in Exp end      { LetT $2 $4 $6 }
      | lam var '::' Type '=' Exp       { LamT $2 $4 $6 }
      | '('Exp Exp')'                   { AppT $2 $3 }

Type : Nat                              { Nat }
     | Bool                             { Boolean }
     | Type '->' Type                   { Arrow $1 $3 }


{
parseError :: [Token] -> a
parseError _ = error "Parse error"

data Token
      = TokenNum Int
      | TokenBool Bool
      | TokenVar Var
      | TokenOB
      | TokenCB
      | TokenSum
      | TokenMult
      | TokenIf
      | TokenThen
      | TokenElse
      | TokenLam
      | TokenEq
      | TokenDots
      | TokenLet
      | TokenIn
      | TokenEnd
      | TokenNat
      | TokenBoolean
      | TokenArrow
      deriving Show


lexer :: String -> [Token]
lexer [] = []
lexer (c:cs) 
      | isSpace c = lexer cs
      | isAlpha c = lexVar (c:cs)
      | isDigit c = lexNum (c:cs)
lexer ('+':cs) = TokenSum : lexer cs
lexer ('*':cs) = TokenMult : lexer cs
lexer ('-':'>':cs) = TokenArrow : lexer cs
lexer (':':':':cs) = TokenDots : lexer cs
lexer ('=':cs) = TokenEq : lexer cs
lexer ('(':cs) = TokenOB : lexer cs
lexer (')':cs) = TokenCB : lexer cs

lexNum cs = TokenNum (read num) : lexer rest
      where (num,rest) = span isDigit cs

lexVar cs =
   case span isAlpha cs of
      ("if", rest) -> TokenIf : lexer rest
      ("then", rest) -> TokenThen : lexer rest
      ("else", rest) -> TokenElse : lexer rest
      ("lam", rest) -> TokenLam : lexer rest
      ("let", rest) -> TokenLet : lexer rest
      ("in", rest) -> TokenIn : lexer rest
      ("end", rest) -> TokenEnd : lexer rest
      ("Nat", rest) -> TokenNat : lexer rest
      ("Bool", rest) -> TokenBoolean : lexer rest
      ("true", rest) -> TokenBool True : lexer rest
      ("false", rest) -> TokenBool False : lexer rest
      (var,rest)   -> TokenVar var : lexer rest

main = getContents >>= print . parser . lexer

{--
EJEMPLO AGREGAR EXPRESIONES A UN LENGUAJE

Ahora nuestro leguaje soporta expresiones como "if 3 then 2 else 4 + 5":

parser $lexer "if 3 then 2 else 4 + 5" = If (Num 3) (Num 2) (Sum (Num 4) (Num 5))
--}

}
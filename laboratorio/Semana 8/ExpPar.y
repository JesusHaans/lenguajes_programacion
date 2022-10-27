{
module ExpPar where
import Data.Char
import Data.List

import Exp

{-
EJEMPLO DE PARSER ELABORADO CON HAPPY
-- Lenguaje correspondiente a Exp, en el cual vimos como funciona Fix
--Este archivo es muy diferente al que estuve viendo en clase, le quite
  todo lo que no era necesario (que venia en el archivo que copie) y lo modifique
  para poder parsear al lenguaje donde vimos como funciona fix

-- Ademas se agrega el ejemplo visto en clase para hacer el parser de recfun y de
   expresiones tipo 'e+'
-}

}

%name parser
%tokentype {Token}
%error {parseError}

%token
      var             { TokenVar $$ }
      num             { TokenNum $$ }
      bool            { TokenBool $$ }
      '('             { TokenOB }
      ')'             { TokenCB }
      '-'             { TokenRes }
      '*'             { TokenMult }
      '=='            { TokenEquals }
      if              { TokenIf }
      then            { TokenThen }
      else            { TokenElse }
      letrec          { TokenLetrec }
      '->'            { TokenArrow }
      '::'            { TokenDots }
      '='             { TokenEq }
      Nat             { TokenNat }
      Bool            { TokenBoolean }
      in              { TokenIn }
      end             { TokenEnd }
      '['             { TokenOBrack }
      ']'             { TokenCBrack }
      recfun          { TokenRecfun }
      lam             { TokenLam }

%left else
%right '->' '='
%nonassoc '=='
%left '-'
%left '*'
%%

Exp   : num                             { Num $1 }
      | var                             { Var $1 }
      | bool                            { B $1 }
      | '(' Exp ')'                     { $2 }
      | Exp '-' Exp                     { Sub $1 $3 }
      | Exp '*' Exp                     { Prod $1 $3 }
      | Exp '==' Exp                    { Equal $1 $3 }
      | if Exp then Exp else Exp        { If $2 $4 $6 }
      | lam var '->' Exp                { Lam $2 $4 }
      | letrec var '=' Exp in Exp end   { Letrec $2 $4 $6 }
      | '(' Exp Exp')'                  { App $2 $3 }
      | recfun var '::' '('Type '->' Type')' vars '=' Exp   {Recfun $2 $5 $7 $9 $11}
      | '[' Exp exps ']'                { AppT $2 $3 }

vars : var          {[$1]}
     | var vars     { $1:$2 }

exps : Exp          {[$1]}
     | Exp exps     { $1:$2 }

Type : Nat              {Nat}
     | Bool             {Boolean}
     | Type '->' Type   {Func $1 $3}



{
parseError :: [Token] -> a
parseError _ = error "Parse error"
 
data Token
      = TokenVar String
      | TokenNum Int
      | TokenBool Bool
      | TokenOB
      | TokenCB
      | TokenRes
      | TokenMult 
      | TokenEquals
      | TokenIf
      | TokenThen
      | TokenElse 
      | TokenLetrec
      | TokenArrow
      | TokenDots
      | TokenEq
      | TokenNat
      | TokenBoolean
      | TokenIn
      | TokenEnd
      | TokenOBrack
      | TokenCBrack
      | TokenRecfun
      | TokenLam
      deriving Show


lexer :: String -> [Token]
lexer [] = []
lexer (c:cs) 
      | isSpace c = lexer cs
      | isAlpha c = lexVar (c:cs)
      | isDigit c = lexNum (c:cs)
lexer ('-':'>':cs) = TokenArrow : lexer cs
lexer ('-':cs) = TokenRes : lexer cs
lexer ('*':cs) = TokenMult : lexer cs
lexer ('(':cs) = TokenOB : lexer cs
lexer (')':cs) = TokenCB : lexer cs
lexer ('[':cs) = TokenOBrack : lexer cs
lexer (']':cs) = TokenCBrack : lexer cs
lexer ('=':'=':cs) = TokenEquals : lexer cs
lexer ('=':cs) = TokenEq : lexer cs
lexer (':':':':cs) = TokenDots : lexer cs

lexNum cs = TokenNum (read num) : lexer rest
      where (num,rest) = span isDigit cs

lexVar cs =
   case span isAlpha cs of
      ("if", rest) -> TokenIf : lexer rest
      ("then", rest) -> TokenThen : lexer rest
      ("else", rest) -> TokenElse : lexer rest
      ("Nat", rest) -> TokenNat : lexer rest
      ("Bool", rest) -> TokenBoolean : lexer rest
      ("recfun", rest) -> TokenRecfun : lexer rest
      ("letrec", rest) -> TokenLetrec : lexer rest
      ("in", rest) -> TokenIn : lexer rest
      ("end", rest) -> TokenEnd : lexer rest
      ("lam", rest) -> TokenLam : lexer rest
      (var,rest)   -> TokenVar var : lexer rest

main = getContents >>= print . parser . lexer
}
{
module ParserLT where
import Data.Char
import Data.List

import MinL
}

%name parser
%tokentype {Token}
%error {parseError}

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
      let             { TokenLet }
      in              { TokenIn }
      end             { TokenEnd }

%left else
%right '='
%left '+'
%left '*'
%%

Exp   : num                             { N $1 }
      | bool                            { B $1 }
      | var                             { V $1 }
      | '(' Exp ')'                     { $2 }
      | Exp '+' Exp                     { Add $1 $3 }
      | Exp '*' Exp                     { Mult $1 $3 }
      | if Exp then Exp else Exp        { If $2 $4 $6 }
      | let var '=' Exp in Exp end      { Let $2 $4 $6 }
      | lam var '=' Exp                 { Lam $2 $4 }
      | '('Exp Exp')'                   { App $2 $3 }


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
      | TokenLet
      | TokenIn
      | TokenEnd
      deriving Show


lexer :: String -> [Token]
lexer [] = []
lexer (c:cs) 
      | isSpace c = lexer cs
      | isAlpha c = lexVar (c:cs)
      | isDigit c = lexNum (c:cs)
lexer ('+':cs) = TokenSum : lexer cs
lexer ('*':cs) = TokenMult : lexer cs
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
      ("true", rest) -> TokenBool True : lexer rest
      ("false", rest) -> TokenBool False : lexer rest
      (var,rest)   -> TokenVar var : lexer rest

main = getContents >>= print . parser . lexer

}
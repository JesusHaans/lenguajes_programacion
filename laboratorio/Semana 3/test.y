{
module Main where
import Data.Char

-- HAPPY DOCS
-- https://www.haskell.org/happy/
}

%name parser
%tokentype { Token }
%error { parseError }

%token 
      num             { TokenNum $$ }
      '+'             { TokenPlus }
      '-'             { TokenMinus }
      '*'             { TokenTimes }
      '/'             { TokenDiv }
      '('             { TokenOB }
      ')'             { TokenCB }

%%


Exp  : Exp '+' Term           { Plus $1 $3 } 
     | Exp '-' Term           { Minus $1 $3 }
     | Term                    { Term $1 }  

Term  : Term '*' Factor         { Times $1 $3 }
      | Term '/' Factor         { Div $1 $3 }
      | Factor                  { Factor $1 }

Factor			  
      : num                     { Num $1 }
      | '(' Exp ')'             { Brack $2 }

{

parseError :: [Token] -> a
parseError _ = error "Parse error"

data Exp 
      = Plus Exp Term 
      | Minus Exp Term 
      | Term Term
      deriving Show

data Term 
      = Times Term Factor 
      | Div Term Factor 
      | Factor Factor
      deriving Show

data Factor 
      = Num Int 
      | Brack Exp
      deriving Show


data Token
      = TokenNum Int
      | TokenPlus
      | TokenMinus
      | TokenTimes
      | TokenDiv
      | TokenOB
      | TokenCB
      deriving Show

lexer :: String -> [Token]
lexer [] = []
lexer (c:cs) 
      | isSpace c = lexer cs
      | isDigit c = lexNum (c:cs)
lexer ('+':cs) = TokenPlus : lexer cs
lexer ('-':cs) = TokenMinus : lexer cs
lexer ('*':cs) = TokenTimes : lexer cs
lexer ('/':cs) = TokenDiv : lexer cs
lexer ('(':cs) = TokenOB : lexer cs
lexer (')':cs) = TokenCB : lexer cs

lexNum cs = TokenNum (read num) : lexer rest
      where (num,rest) = span isDigit cs --- "34 + 2" => ("34", " + 2")

main = getContents >>= print . parser . lexer

}
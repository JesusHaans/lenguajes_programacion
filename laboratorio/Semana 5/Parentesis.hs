module Parentesis where

data Token = ParO | ParC | Desconocido Char deriving (Eq, Show)

data BP = Eps | Par BP| Conc BP BP deriving (Eq, Show) -- (bp) ! ()()

lexer :: String -> [Token]
lexer = map lexi

lexi :: Char -> Token
lexi c = case c of
        '(' -> ParO
        ')' -> ParC
        c -> Desconocido c

parser :: [Token] -> BP
parser xs = if count > 0
            then error "Parser error: Not expected token '('"
            else bp
          where (bp, count) = parserAux xs Eps 0

parserAux :: [Token] -> BP -> Int -> (BP, Int)
parserAux [] bp n = (bp,n)
parserAux (ParO:xs) bp n = parserAux xs (Par bp) (n+1)
parserAux (ParC:xs) bp n = case n of
                       0 -> error "Parser error: Not expected token ')'"
                       1 ->  if bbp == Eps
                             then (bp , 0)
                             else (Conc bp bbp, c)
                         where (bbp , c ) = parserAux xs Eps 0
                       n -> parserAux xs bp (n-1)
parserAux _ _ _ = error "Parser error: Wrong Token"

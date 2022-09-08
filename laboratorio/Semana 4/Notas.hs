{--
NOTAS IMPORTANTES

-Practica 1
-- Se corrigieron unos pequeños errores en la P1, revisarlos. Igual si veo que
   tienen errores en su codigo les dejare un comentario en el PR de feedback
-- NO toquen la rama feedback, todo debe subirse a Main
-- Se les pasara un nuevo archivo de pruebas, con correciones y pruebas para
   los ejercicios de árboles


Instalación de QuickCheck
1.- Actualizar lista de paquetes de cabal
   $ cabal update
2.- Instalar QuickCheck
   $ cabal install --lib QuickCheck

Es Todo :) jajaja

-Practica 2
-- Se dejara este viernes
-- Proceso de analisis lexico y sintactico

Instalacion de Happy
  $ cabal install happy


- EJERCICIO 
Lexer y parser parentesis balanceados

Estos datos algebraicos representan los asa y los token de un lenguaje
de parentesis balanceados.
data M = E
   | Par M - -( M )
   | Conc M M -- MM
    deriving ( Show , Eq )

data Tokens = ParA
   | ParC
   | Desconocido Char
    deriving ( Show , Eq )

1.- lexer. Esta función recibirá una cadena de texto y devolverá una lista de Tokens

2.- Implemente una función parser para las expresiones
--}
module Notas where
import Data.Char
import Data.List

data M = E
   | Par M --( M )
   | Conc M M -- MM
    deriving ( Show , Eq )

data Tokens = ParA
   | ParC
   | Desconocido Char
    deriving ( Show , Eq )

lexer :: String -> [Tokens]
lexer [] = []
lexer (' ':xs) = lexer xs
lexer ('(':xs) = ParA : lexer xs
lexer (')':xs) = ParC : lexer xs
lexer (x:xs) = Desconocido x : lexer xs

parser :: [Tokens] -> M
parser [] = E
parser t@((Desconocido x):xs) = parseError t
parser (ParA:(ParC:xs)) = if xs == [] then Par E else Conc (Par E) (parser xs)
parser t@(ParA:xs) = if (last xs) == ParC then Par (parser (init xs)) else  parseError t
parser t@(ParA:((Desconocido x):xs)) = parseError t 
parser t@(ParC:xs) = parseError t
parser t@(ParA:[]) = parseError t



parseError :: [Tokens] -> a
parseError _ = error "Parse error"
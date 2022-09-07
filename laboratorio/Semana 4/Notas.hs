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
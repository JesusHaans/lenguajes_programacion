{-- 
DUDAS RESUELTAS DURANTE LA SESIÓN

1.- Si tengo la pila [3,8,4,2,7] y hago nget -> vind = 3, pila = [8,4,2,7],
 j = 2, 1 <= 2 <= n = 4, entonces agregamos a vj, nos queda [2,8,4,2,7] ? o 
 nos queda [2,8,4,7] (Minuto 2)

 vind = 3; n = 4 ; 1 <= 3 <= 4 SE CUMPLE =>      PILA = [2,8,4,2,7]

2.- En las pruebas del archivo Test.hs se tiene que la primera regresa 16 
 (la primera ejecución de acá abajo). Pero en el segundo ejemplo del pdf de la tarea 
 se tiene que hay una pila con 20 en el tope y 6 en el tope.tope. Mi pregunta es, 
 ambos tienen al mayor en el tope y al menor en el tope.tope, pero una regresa un 
 número positivo y otra negativo (tope - tope.tOpe vs tope.tope - tope), ¿Cuál está bien?
  [4,2,3,2] -> add, [6,3,2] -> mul [18, 2] -> sub [16] (Minuto 7)
   ...                  [20,6] -> sub [-14] 
HAY UN ERROR EN LA PRUEBA

---- TEST
[4,2,3,2] postfix 4 add mul sub
-> [6,3,2] -> [18,2] -> [-16]

3.- Confusion con TOKEN.... (Minuto 14)

4.- Ejemplo de funcion lexer (Minuto 22)
lexer "postfix 4 add mul sub" = [TPostfix, Tnum 4, Tadd, Tmul, Tsub]

5.- Ejemplo Parser con los parentesis clase anterior (Minuto 27)
lerxer "(())()" => [ParO,ParO,ParC,ParC,ParO,ParC]
parser [ParO,ParO,ParC,ParC,ParO,ParC] => Conc (Par (Par Eps)) (Par Eps)

6.- ejemplo parser EAB (Minuto 29)
parser $ lexer "3*8+4" => Sum (Mul (N 3) (N 8)) (N 4)

7.- explicacion rapida Eab (Minuto 35)
Hint: lexer (a:b:xs) ... (es un patron valido para haskell)

ejemplo span
span isDigit "23 + 2"  = ("23", " + 2")

-}
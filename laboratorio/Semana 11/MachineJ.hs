module MachineJ where
import MinL (MinL)

{-
Ejercicio extra P5
Implementar la máquina J para el lenguaje MinL con el que hemos venido trabajando
en el laboratorio

Este debe tener estartegia de evaluación ansiosa, utilizar ambientes y tener
un alcance estatico de variables

Fecha de entrega: 22/11/2022 11:59 pm
-}

data Value = Num Int deriving (Show, Eq)

evalVJ :: MinL -> Value
evalVJ _ = error "Implementar"
-- Módulo en el que definimos Árboles Binarios
module BinaryTree where

    data BT a = Void
              | Node a (BT a) (BT a)
              deriving (Show)

    -- Calcula la áltura de un árbol
    high :: BT a -> Int
    high Void = 0
    high (Node x t1 t2) = 1 + (max (high t1)  (high t2))
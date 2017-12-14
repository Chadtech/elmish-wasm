module Main where

import qualified System.Environment as System


main :: IO ()
main = do
    fileName <- System.getArgs
    putStrLn (show fileName)
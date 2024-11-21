module Main where

import Status.Schema
import Interpreter
import System.IO

flow :: Universe -> IO ()
flow u = do
  putStr (show u ++ "\nInput: ")
  hFlush stdout
  input <- getLine
  let newUniverse = interpret input u
  if halt (time u) then print "Halting" else flow newUniverse

main :: IO ()
main = do
  flow Status.Schema.seed

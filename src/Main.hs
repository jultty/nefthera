module Main where

import Status.Schema

flow :: Universe -> Universe
flow u = u

main :: IO ()
main = do
  Status.Schema.write

{-# LANGUAGE DeriveGeneric  #-}

module Status.Schema where

import GHC.Generics
import Data.Aeson
import qualified Data.Text as T

data Status

data Time = Time {
    halt :: Bool
  , grain :: Integer
} deriving Show

data Gauge = Gauge {
    minimum :: Int
  , maximum :: Int
} deriving Show

newtype View = View {main :: T.Text} deriving Show

data Vocation = Bladewielder | Archer | Psycher | Summoner deriving Show
data Knowledge = Yi | Location
data Craft = Fledging | Sharpening | Brewing
data Skill = Archery | Swordfighting
data Enchanting = Phylactery | Accurseing | Animation
data Sorcery = Psyching | Cursing | Haunting | Enchanting | Transmutation | Conjuration

data Player = Player {
    health :: Gauge
  , mana :: Gauge
  , vocation :: Vocation
} deriving Show

data Universe = Universe {
  -- , time :: Time
  -- , player :: Player
  -- , view :: View
  } deriving (Generic, Show)

universe :: Universe
universe = Universe {}

encodeUniverse :: Universe -> Encoding
encodeUniverse = genericToEncoding defaultOptions

print :: IO ()
print = do
  Prelude.print (encodeUniverse universe )

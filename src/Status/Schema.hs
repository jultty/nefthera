{-# LANGUAGE DeriveGeneric  #-}

module Status.Schema where

import GHC.Generics
import Data.Aeson
import qualified Data.Text as T

data Universe = Universe {
  time :: Time
  , view :: View
  , player :: Player
  , meta :: Metadata
} deriving (Generic, Show); instance ToJSON Universe

data Time = Time {
  grain :: Integer
  , halt :: Bool
} deriving (Show, Generic); instance ToJSON Time

data View = View {
  primary :: T.Text
  , secondary :: T.Text
} deriving (Show, Generic); instance ToJSON View

data Player = Player {
  health :: Gauge
  , mana :: Gauge
  , capabilities :: Capabilities
} deriving (Show, Generic); instance ToJSON Player

data Gauge = Gauge {
  current :: Int
  , total :: Int
} deriving (Show, Generic); instance ToJSON Gauge

data Capabilities = Capabilities {
  vocation :: Vocation
  , skill :: Skill
  , magic :: Magic
  , craft :: Craft
  , knowledge :: Knowledge
} deriving (Show, Generic); instance ToJSON Capabilities

data Vocation = Vocation {
  vanguard :: Int
  , archer :: Int
  , psycher :: Int
  , summoner :: Int
} deriving (Show, Generic); instance ToJSON Vocation

data Skill = Skill {
  archery :: Int
  , bladefighting :: Int
} deriving (Show, Generic); instance ToJSON Skill

data Magic = Magic {
  psyching :: Int
  , cursing :: Int
  , haunting :: Int
  , enchanting :: Enchanting
  , transmutation :: Int
  , conjuration :: Int
} deriving (Show, Generic); instance ToJSON Magic

data Enchanting = Enchanting {
  phylactery :: Int
  , accurseing :: Int
  , animation :: Int
} deriving (Show, Generic); instance ToJSON Enchanting

data Craft = Craft {
  fledging :: Int
  , sharpening  :: Int
  , brewing :: Int
} deriving (Show, Generic); instance ToJSON Craft

data Knowledge = Knowledge {
  yi :: Int
  , location :: Int
} deriving (Show, Generic); instance ToJSON Knowledge

newtype Metadata = Metadata {
  version :: Version
} deriving (Show, Generic); instance ToJSON Metadata

data Version = Version {
  major :: Int
  , minor :: Int
  , patch :: Int
} deriving (Show, Generic); instance ToJSON Version

seed :: Universe
seed = Universe {
  time = Time {
    grain = 0
    , halt = False
  }
  , view = View {
    primary = T.pack "primary view element"
    , secondary = T.pack "secondary view element"
  }
  , player = Player {
    health = Gauge { current = 100, total = 100 }
    , mana = Gauge { current = 0, total = 40 }
    , capabilities = Capabilities {
      vocation = Vocation {
        vanguard = 0
        , archer = 0
        , psycher = 0
        , summoner = 0
      }
      , skill = Skill {
        archery = 0
        , bladefighting = 0
      }
      , magic = Magic {
        psyching = 0
        , cursing = 0
        , haunting = 0
        , enchanting = Enchanting {
          phylactery = 0
          , accurseing = 0
          , animation = 0
        }
        , transmutation = 0
        , conjuration = 0
      }
      , craft = Craft {
        fledging = 0
        , sharpening = 0
        , brewing = 0
      }
      , knowledge = Knowledge {
        yi = 0
        , location = 0
      }
    }
  }
  , meta = Metadata {
    version = Version {
      major = 0
      , minor = 1
      , patch = 0
    }
  }
}

encodeUniverse :: Universe -> Encoding
encodeUniverse = genericToEncoding defaultOptions

write :: IO ()
write = do
  print (encodeUniverse seed)

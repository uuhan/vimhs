{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell   #-}
module Neovim.Plugins.GLSL.Api
  where

import           Data.Aeson
import           Data.Aeson.TH
import           Data.FileEmbed
import           Data.Either
import qualified Data.ByteString.Lazy.Char8 as BL
import qualified Data.ByteString.Char8 as BS
import qualified Data.Map                   as Map
import           GHC.Generics

data Api = Api
         { name        :: String
         , description :: String
         , usage       :: String
         , parameters  :: Map.Map String String
         } deriving(Generic, Show)

$(deriveJSON defaultOptions ''Api)

apis :: [Api]
apis = either error id
     . eitherDecode
     . BL.fromStrict
     $ $(embedFile "blobs/api.json")

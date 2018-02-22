{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards   #-}
module Neovim.Plugins.GLSL.Plugin
  where

import qualified Data.ByteString.Char8   as BL
import           Data.List
import qualified Data.Map                as Map
import           Neovim
import           Neovim.Log (errorM)
import           Neovim.Plugins.GLSL.Api (Api (..), apis)

-- | Omnifunc
glsl :: Object -> Object -> Neovim' Object
-- | return findstart
glsl (ObjectString _) (ObjectString s) = Neovim.vim_get_current_line' >>= pure . getPos
glsl (ObjectInt 1) _ = Neovim.vim_get_current_line' >>= pure . getPos

-- | return completion
glsl (ObjectInt _) (ObjectString s)
  | "gl." `isPrefixOf` BL.unpack s = pure . completions (BL.unpack s) $ apis
  | otherwise = pure $ ObjectArray []

getPos :: String -> Object
getPos s = go 0 s
  where go _ [] = ObjectInt (-1)
        go n f@(x:xs) | n > length s = ObjectInt (-1)
                      | "gl." `isPrefixOf` f = ObjectInt . fromIntegral $ n
                      | otherwise = go (n+1) xs

completions :: String -> [Api] -> Object
completions prefix as =
  let
    ts Api{..} = ObjectMap $ Map.fromList [ (ObjectString "word", to name)
                                          , (ObjectString "menu", to description)
                                          ]
    cs = map ts $ filter (\Api{..} -> prefix `isPrefixOf` name) as
  in
    ObjectArray cs

to :: String -> Object
to s = ObjectString $ BL.pack s

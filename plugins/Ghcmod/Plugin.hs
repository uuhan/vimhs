{-# LANGUAGE OverloadedStrings #-}
module Ghcmod.Plugin
  where

import           Neovim as N
import           Neovim.Log as N
import           Data.Map
import           Data.List as L
import qualified          Data.ByteString as BS
import           Data.Maybe
import           Data.Word8 (_space)

-- | Omnifunc
ghcmod :: Object -> Object -> Neovim' Object
-- | return completion
ghcmod (ObjectInt i) (ObjectString s) = do
    liftIO $ errorM "ghcmod" $ "Int String" ++ show i
    liftIO $ errorM "ghcmod" $ "Int String" ++ show s
    return $ ObjectArray [ObjectMap $ fromList [(ObjectString "word", ObjectString (s <> "1 .. by")), (ObjectString "menu", ObjectString "ghcby")]]

-- | return findstart
ghcmod (ObjectString i) (ObjectString s) = do
    liftIO $ errorM "ghcmod" $ "String String" ++ show i
    liftIO $ errorM "ghcmod" $ "String String" ++ show s
    gline <- N.vim_get_current_line
    let line = either (const "error") (id) gline
        idx = maybe 0 id (L.findIndex (/= ' ') line)
    liftIO $ errorM "ghcmod" $ show idx
    liftIO $ errorM "ghcmod" $ line
    return $ ObjectInt $ fromIntegral idx

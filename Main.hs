module Main where

import           Neovim
import qualified Neovim.Ghcid as Ghcid
import qualified Neovim.Plugins.Ghcmod as Ghcmod
import qualified Neovim.Plugins.GLSL  as GLSL
import qualified Neovim.Plugins.Spider as Spider

import qualified System.Environment as Env

main :: IO ()
main = do
  home <- Env.getEnv "HOME"
  neovim defaultConfig
    { plugins = plugins defaultConfig <>
      [ Ghcid.plugin
      , Ghcmod.plugin
      , GLSL.plugin
      , Spider.plugin
      ]
    , logOptions = Just (home ++ "/vimhs.log", DEBUG)
    }

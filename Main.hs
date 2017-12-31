module Main where

import qualified Fibonacci
import qualified Ghcmod
import           Neovim
import qualified Neovim.Ghcid as Ghcid

main :: IO ()
main = neovim defaultConfig { plugins = plugins defaultConfig
                                          <> [ Ghcid.plugin
                                             , Fibonacci.plugin
                                             , Ghcmod.plugin
                                             ]
                            , logOptions = Just ("/Users/xu/vimhs.log", DEBUG)
                            }

module Main where

import qualified Fibonacci
import           Neovim
import qualified Neovim.Ghcid as Ghcid

main :: IO ()
main = neovim defaultConfig { plugins = plugins defaultConfig
                                          <> [ Ghcid.plugin
                                             , Fibonacci.plugin
                                             ]
                            , logOptions = Just ("/Users/xu/vimhs.log", DEBUG)
                            }

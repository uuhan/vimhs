{-# LANGUAGE TemplateHaskell #-}
module Neovim.Plugins.HackerNews
  ( plugin )
  where

import           Neovim.Plugins.HackerNews.Plugin (hn)
import           Neovim

plugin :: Neovim (StartupConfig NeovimConfig) () NeovimPlugin
plugin = wrapPlugin Plugin { exports         = [$(function' 'hn) Sync]
                           , statefulExports = []
                           }

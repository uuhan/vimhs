{-# LANGUAGE TemplateHaskell #-}
module HackerNews
  ( plugin )
  where

import           HackerNews.Plugin (hn)
import           Neovim

plugin :: Neovim (StartupConfig NeovimConfig) () NeovimPlugin
plugin = wrapPlugin Plugin { exports         = [$(function' 'hn) Sync]
                           , statefulExports = []
                           }

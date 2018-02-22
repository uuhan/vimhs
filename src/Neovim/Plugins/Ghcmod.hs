{-# LANGUAGE TemplateHaskell #-}
module Neovim.Plugins.Ghcmod
  ( plugin )
  where

import           Neovim.Plugins.Ghcmod.Plugin (ghcmod)
import           Neovim

plugin :: Neovim (StartupConfig NeovimConfig) () NeovimPlugin
plugin = wrapPlugin Plugin { exports         = [$(function' 'ghcmod) Sync]
                           , statefulExports = []
                           }

{-# LANGUAGE TemplateHaskell #-}
module Ghcmod
  ( plugin )
  where

import           Ghcmod.Plugin (ghcmod)
import           Neovim

plugin :: Neovim (StartupConfig NeovimConfig) () NeovimPlugin
plugin = wrapPlugin Plugin { exports         = [$(function' 'ghcmod) Sync]
                           , statefulExports = []
                           }

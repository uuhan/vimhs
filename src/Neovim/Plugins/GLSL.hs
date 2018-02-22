{-# LANGUAGE TemplateHaskell #-}
module Neovim.Plugins.GLSL
  ( plugin )
  where

import           Neovim
import           Neovim.Plugins.GLSL.Plugin

plugin :: Neovim (StartupConfig NeovimConfig) () NeovimPlugin
plugin = wrapPlugin Plugin { exports = [$(function' 'glsl) Sync]
                           , statefulExports = []
                           }

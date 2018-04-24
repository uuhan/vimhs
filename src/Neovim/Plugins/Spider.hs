module Neovim.Plugins.Spider
  where

import           Neovim
import           Neovim.Plugins.Spider.Plugin (spider)

plugin :: Neovim (StartupConfig NeovimConfig) () NeovimPlugin
plugin = do
  wrapPlugin Plugin { exports = [$(command' 'spider) ["sync"]]
                    , statefulExports = []
                    }

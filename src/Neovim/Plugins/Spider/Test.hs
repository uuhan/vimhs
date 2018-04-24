module Neovim.Plugins.Spider.Test
  where

import           Text.HTML.Scalpel
import           Data.Text

test :: Scraper String String
test =
  chroot ("head" // "style") $ do
    text anySelector

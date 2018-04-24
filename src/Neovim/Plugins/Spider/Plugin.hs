{-# LANGUAGE RecordWildCards #-}
module Neovim.Plugins.Spider.Plugin
  where

import           Neovim hiding (text)
import           Neovim.User.Input

import           Text.HTML.Scalpel
import           Neovim.Plugins.Spider.Test (test)

import           Control.Monad
import           Data.Maybe
import           Data.Text (unpack)
import           Data.Aeson
import           Data.Aeson.TH
import qualified Data.ByteString.Lazy.Char8 as BL
import           System.IO

data Schema = Schema
            { location :: [String]
            } deriving (Show)

data SResult = SResult
            { result :: String
            } deriving (Show)

deriveJSON defaultOptions ''Schema
deriveJSON defaultOptions ''SResult

spider :: CommandArguments -> Neovim' ()
spider copts = do
  url <- askForString "输入地址: " Nothing
  modal <- askForString "路径: " Nothing
  let (Just Schema{..}) = decode (BL.pack modal) :: Maybe Schema
  let scraper = chroot (foldl1 (//) $ map tagSelector location) (text anySelector)
  r <- liftIO $ scrapeURLWithOpts [] url scraper
  to_vim r
  where
    to_vim Nothing = return ()
    to_vim (Just result) = do
      let height = 5
      Neovim.nvim_command' $ "below " ++ show height ++ " split"
      Neovim.nvim_command' "enew"
      buf <- Neovim.nvim_get_current_buf'
      Neovim.buffer_set_option' buf "buftype" $ ObjectString "nofile"
      Neovim.nvim_command' "autocmd WinLeave <buffer> :bd"
      Neovim.buffer_set_lines' buf 0 1 False [BL.unpack $ encode $ SResult result]

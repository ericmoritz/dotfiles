#!/usr/local/bin/stack
{- stack
    --resolver lts-14.2
    script
    --package time
 -}
{-# LANGUAGE OverloadedStrings #-}
import Data.Time.Clock
import Data.Time.LocalTime
import System.Process


data Mode = LongBreak | Break | Work
modeStr :: Mode -> String
modeStr LongBreak = "Long Break"
modeStr Break = "Break"
modeStr Work = "Work"

-- work for 25 minutes from :05 to :30
-- take a 5 minute break from :30 to :35
-- work for 25 minutes from :35 to :00
-- take a 5 minute break from :00 to :05
-- every three hours (at 12-3-6-9) the :05-:30 work cycle is substituted for a break, which lasts 35 minutes.
timeToMode :: LocalTime -> Mode
timeToMode x
  | hour `mod` 3 == 0 && minute < 35  = LongBreak
  | minute < 5                        = Break
  | minute >= 30 && minute < 35       = Break
  | otherwise                         = Work
  where local =localTimeOfDay x
        hour = todHour local
        minute = todMin local

notifyMode :: Mode -> IO ()
notifyMode = do
  

handleModeChange :: Mode -> Mode -> IO ()
handleModeChange old new 
 | old == new = return ()
 | otherwise  = do
     notifyMode new

main :: IO ()
main = do
  localTime <- utcToLocalTime <$> getCurrentTimeZone <*> getCurrentTime
  oldMode <- loadState
  let newMode = timeToMode localTime
  handleModeChange oldMode newMode
  putStrLn $ modeStr newMode
    


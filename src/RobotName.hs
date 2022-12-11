module Robot (Robot, initialState, mkRobot, resetName, robotName) where
-- https://exercism.org/tracks/haskell/exercises/robot-name/
-- ref https://exercism.org/tracks/haskell/exercises/robot-name/solutions/guygastineau
import Control.Monad.State (StateT, get, put)
import System.Random ( randomRIO )
import Control.Monad.IO.Class (liftIO)
import Data.IORef ( IORef, newIORef, readIORef, writeIORef )
import qualified Data.Set as Set
import Data.Set (Set)

newtype Robot = Robot (IORef String)
type RunState = Set String

initialState :: RunState
initialState = Set.empty

mkNewName = sequence [randomRIO ('A', 'Z'), randomRIO ('A', 'Z'), randomRIO ('0', '9'), randomRIO ('0', '9'), randomRIO ('0', '9')]

mkRobot :: StateT RunState IO Robot
mkRobot = do
    newName <- mkNewName
    cache <- get
    if Set.member newName cache
        then mkRobot
        else do put $ Set.insert newName cache
                liftIO (Robot <$> newIORef newName)


resetName :: Robot -> StateT RunState IO ()
resetName robot@(Robot nameRef) = do
    oldName <- liftIO $ robotName robot
    newName <- mkNewName
    cache <- get
    if Set.member newName cache
        then resetName robot
        else do liftIO $ writeIORef nameRef newName
                put (Set.insert newName (Set.delete oldName cache))
                return ()

robotName :: Robot -> IO String
robotName (Robot name) = readIORef name

-- >>> sequence [randomRIO ('A', 'Z'), randomRIO ('A', 'Z'), randomRIO ('0', '9'), randomRIO ('0', '9'), randomRIO ('0', '9')]
-- "LY063"
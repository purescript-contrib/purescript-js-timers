module Test.Main where

import Prelude

import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console as C
import Control.Monad.Eff.Ref as R
import Control.Monad.Eff.Timer as T

import Test.Assert (ASSERT, assert)

main :: Eff (ref :: R.REF, timer :: T.TIMER, console :: C.CONSOLE, assert :: ASSERT) Unit
main = do
  counter <- R.newRef 0

  void $ T.setTimeout 10 do
    C.log "timeout increment counter"
    R.modifyRef counter (_ + 1)

  void $ T.setTimeout 50 do
    C.log "timeout check counter"
    n <- R.readRef counter
    assert $ n == 1

  void $ T.setTimeout 100 do

    t <- T.setTimeout 20 do
      R.modifyRef counter (_ + 1)

    T.clearTimeout t

    void $ T.setTimeout 50 do
      C.log "check timeout never ran"
      n <- R.readRef counter
      assert $ n == 1

  void $ T.setTimeout 200 do

    i <- T.setInterval 20 do
      C.log "interval increment counter"
      R.modifyRef counter (_ + 1)

    void $ T.setTimeout 90 do
      T.clearInterval i
      C.log "interval check counter"
      n <- R.readRef counter
      assert $ n == 5

    void $ T.setTimeout 150 do
      C.log "check interval has stopped"
      n <- R.readRef counter
      assert $ n == 5

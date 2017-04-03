module Control.Monad.Eff.Timer
  ( TIMER
  , TimeoutId
  , setTimeout
  , clearTimeout
  , IntervalId
  , setInterval
  , clearInterval
  ) where

import Prelude

import Control.Monad.Eff (kind Effect, Eff)

-- | The effect for the usage of a JavaScript timer.
foreign import data TIMER :: Effect

-- | The ID of a timer started with `setTimeout`.
newtype TimeoutId = TimeoutId Int

derive instance eqTimeoutId :: Eq TimeoutId
derive instance ordTimeoutId :: Ord TimeoutId

-- | Runs an effectful function after the specified delay in milliseconds. The
-- | returned `TimeoutId` can be used to cancel the timer before it completes.
-- |
-- | The timeout delay value is capped at 4ms by the JS API, any value less than
-- | this will be clamped.
foreign import setTimeout
  :: forall eff
   . Int
  -> Eff (timer :: TIMER | eff) Unit
  -> Eff (timer :: TIMER | eff) TimeoutId

-- | Cancels a timeout. If the timeout has already been cancelled or has already
-- | elapsed this will have no effect.
foreign import clearTimeout
  :: forall eff
   . TimeoutId
  -> Eff (timer :: TIMER | eff) Unit

-- | The ID of a timer started with `setInterval`.
newtype IntervalId = IntervalId Int

derive instance eqIntervalId :: Eq IntervalId
derive instance ordIntervalId :: Ord IntervalId

-- | Runs an effectful function after on a set interval with the specified delay
-- | in milliseconds between iterations. The returned `IntervalId` can be used
-- | to cancel the timer and prevent the interval from running any further.
-- |
-- | The interval delay value is capped at 4ms by the JS API, any value less
-- | than this will be clamped.
foreign import setInterval
  :: forall eff
   . Int
  -> Eff (timer :: TIMER | eff) Unit
  -> Eff (timer :: TIMER | eff) IntervalId

-- | Cancels an interval timer. If the interval has already been cancelled this
-- | will have no effect.
foreign import clearInterval
  :: forall eff
   . IntervalId
  -> Eff (timer :: TIMER | eff) Unit

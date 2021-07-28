{ name = "js-timers"
, dependencies =
  [ "assert", "console", "effect", "prelude", "psci-support", "refs" ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}

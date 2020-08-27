{ name = "js-timers"
, dependencies = [ "assert", "console", "effect", "psci-support", "refs" ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}

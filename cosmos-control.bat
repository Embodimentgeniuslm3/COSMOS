@echo off

if ("%1"=="") (
  GOTO usage
)
<<<<<<< HEAD
if "%1" == "config" (
  GOTO config
=======
if "%1" == "restart" (
  GOTO restart
>>>>>>> e1b2834dd9dba899266fedffecf67bd6894fa83f
)
if "%1" == "start" (
  GOTO startup
)
if "%1" == "stop" (
  GOTO stop
)
if "%1" == "cleanup" (
  GOTO cleanup
)
if "%1" == "build" (
  GOTO build
)
if "%1" == "run" (
  GOTO run
)
if "%1" == "deploy" (
  GOTO deploy
)

GOTO usage

:startup
  CALL scripts/windows/cosmos_setup
  CALL scripts/windows/cosmos_build
  CALL scripts/windows/cosmos_run
  @echo off
GOTO :EOF

:stop
  CALL scripts/windows/cosmos_stop
  @echo off
GOTO :EOF

:cleanup
  CALL scripts/windows/cosmos_cleanup
  @echo off
GOTO :EOF

:build
  CALL scripts/windows/cosmos_setup
  CALL scripts/windows/cosmos_build
  @echo off
GOTO :EOF

:run
  CALL scripts/windows/cosmos_run
  @echo off
GOTO :EOF

:deploy
  CALL scripts/windows/cosmos_deploy
  @echo off
GOTO :EOF

:restart
  CALL scripts/windows/cosmos_restart
  @echo off
GOTO :EOF

:usage
  @echo Usage: %0 [start, stop, cleanup, build, run, deploy] 1>&2
  @echo *  start: run the docker containers for cosmos 1>&2
  @echo *  stop: stop the running docker containers for cosmos 1>&2
  @echo *  restart: stop and run the minimal docker containers for cosmos 1>&2
  @echo *  cleanup: cleanup network and volumes for cosmos 1>&2
  @echo *  build: build the containers for cosmos 1>&2
  @echo *  run: run the prebuilt containers for cosmos 1>&2
  @echo *  deploy: deploy the containers to localhost repository 1>&2

@echo on

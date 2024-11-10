REM ECHO OFF
REM CLS

SET RIETAN=%~dp0\STRUCTURE_TIDY

IF NOT EXIST "%RIETAN%\structure_tidy.exe" (
   GOTO END
)

IF NOT EXIST %1 (
   GOTO END
)

SET SAMPLE=%~n1
CHDIR /D %~dp1
"%RIETAN%\structure_tidy.exe" "%SAMPLE%.stin" > "%SAMPLE%-tmp.sto"

:END

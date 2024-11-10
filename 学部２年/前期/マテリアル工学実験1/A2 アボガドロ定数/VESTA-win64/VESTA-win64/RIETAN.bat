ECHO OFF
CLS


SET SAMPLE=%~n1
SET SAMPLE_DIR=%~dp1
CHDIR /D %SAMPLE_DIR%
SET RIETAN=%~dp2

IF NOT EXIST "%RIETAN%rietan.exe" (
   Echo File does not exist: %RIETAN%rietan.exe
   PAUSE
   GOTO END
)

REM SET VIEWER_DIR=%~dp3

SET TEE=%RIETAN%
IF NOT EXIST "%TEE%tee.exe" (
   SET TEE=%RIETAN%Commands\
)

ECHO RIETAN-FP is now running ...
REM  Input *.ins: Standard input.
REM        *.int: X-ray/neutron diffraction data.
REM        *.bkg: Background intensities.
REM        *.ffe: Input data created by ORFFE for imposing constraints on interatomic distances and/or bond angles.
REM        *.fba: Data created by PRIMA for MEM-based whole-pattern fitting.
REM        *.ffi: Initial integrated intensities for Le Bail refinement.
REM Output *.itx: Data for plotting Rietveld-refinement patterns or a simulated pattern.
REM        *.hkl: Data for Fourier/D synthesis by FOUSYN.
REM        *.xyz: Data for calculating interatomic distances and bond angles by ORFFE.
REM        *.fos: Data for MEM analysis by PRIMA.
REM        *.ffo: Integrated intensities resulting from Le Bail refinement.
REM        *.vesta: VESTA text file.
REM        *.plt: gnuplot script file to plot Rietveld-refinement patterns or a simulated pattern.
REM        *.gpd: gnuplot data file to plot Rietveld-refinement patterns or a simulated pattern.
REM        *.lst: Standard output.
DEL "%SAMPLE%.lst" "%SAMPLE%.gpd" "%SAMPLE%.plt" "%SAMPLE%.itx" "%SAMPLE%.xyz" "%SAMPLE%.pdf"
IF EXIST "%RIETAN%Commands\RIETAN.command" (
  "%RIETAN%Commands\bash.exe" "%RIETAN%Commands\RIETAN.command" "%SAMPLE%"
  IF EXIST "%SAMPLE%.plt" (
    "%RIETAN%Commands\bash.exe" "%RIETAN%Commands\Plot.command" "%SAMPLE%"
  )
  IF EXIST "%SAMPLE%.pdf" (
     START "" "%SAMPLE%.pdf"
  )
) ELSE (
  IF EXIST "%RIETAN%rietan64.exe" (
    "%RIETAN%rietan64.exe" "%SAMPLE%.ins" "%SAMPLE%.int" "%SAMPLE%.bkg" "%SAMPLE%.itx" "%SAMPLE%.hkl" "%SAMPLE%.xyz" "%SAMPLE%.fos" "%SAMPLE%.ffe" "%SAMPLE%.fba" "%SAMPLE%.ffi" "%SAMPLE%.ffo" "%SAMPLE%.vesta" "%SAMPLE%.plt" "%SAMPLE%.gpd" "%SAMPLE%.alb" "%SAMPLE%.prf" "%SAMPLE%.inflip" "%SAMPLE%.exp" | "%TEE%tee.exe" "%SAMPLE%.lst"
  ) ELSE (
    "%RIETAN%rietan.exe" "%SAMPLE%.ins" "%SAMPLE%.int" "%SAMPLE%.bkg" "%SAMPLE%.itx" "%SAMPLE%.hkl" "%SAMPLE%.xyz" "%SAMPLE%.fos" "%SAMPLE%.ffe" "%SAMPLE%.fba" "%SAMPLE%.ffi" "%SAMPLE%.ffo" "%SAMPLE%.vesta" "%SAMPLE%.plt" "%SAMPLE%.gpd" "%SAMPLE%.alb" "%SAMPLE%.prf" "%SAMPLE%.inflip" "%SAMPLE%.exp" | "%TEE%tee.exe" "%SAMPLE%.lst"
  )
  IF EXIST "%SAMPLE%.plt" (
        call "%RIETAN%/Batch_files/Plot.bat" "%SAMPLE_DIR%%SAMPLE%"
  )
)
REM Display *.itx
REM In what follows, file names after "START" are titles displayed in window title bars.
REM Enter "help START" in the Command Prompt to learn arguments of START.
REM The base name of *.ins should not contain a space because %SAMPLE%.plt cannot be enclosed by " ".
START "" "%SAMPLE_DIR%"
IF EXIST "%SAMPLE%.pdf" (
  REM Do nothing
) ELSE IF EXIST "%SAMPLE%.itx" (
  REM If *.plt exist, not Igor.exe but wgnuplot.exe is launched.
  REM START "%SAMPLE%.itx" /B "%SAMPLE%.itx"
  IF EXIST %3 (
     REM START "%SAMPLE_DIR%%SAMPLE%.itx" /B "%SAMPLE_DIR%%SAMPLE%.itx"
     IF "%~x3" == ".jar" (
        REM CHDIR /D %~dp3
        START /D "%~dp3" javaw -jar %~nx3 "%SAMPLE_DIR%%SAMPLE%.itx"
     ) ELSE (
        START /D "%~dp3" %~nx3 "%SAMPLE_DIR%%SAMPLE%.itx"
     )
  ) ELSE (
     START /D "%SAMPLE_DIR%" "%SAMPLE%.itx" /B "%SAMPLE%.itx"
  )
REM   ping localhost -n 5 > nul
) ELSE (
   Echo RIETAN stoped with an error. Check the output file, "%SAMPLE%.lst".
   PAUSE
   START "%SAMPLE%.lst" /B "%SAMPLE%.lst"
)

:END

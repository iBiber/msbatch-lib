@ECHO OFF
:: ====================================================
:request_user_yn_input
:: %~1 - Target variable reference to store the result
:: %~2 - Text to display
SETLOCAL

:question
echo.
set answer=
set /p answer=%~2 [y/n] (default y): 
for %%A in (Y N) Do (
  if /i '%answer%'=='%%A' (
    goto :continue
  )
)

if /i '%answer%'=='' (
	set answer=y
	goto :continue
)

ECHO Only 'y' or 'n' is allowed & GOTO question

:continue
( ENDLOCAL
  SET %~1=%answer%
)
goto:eof
:: ====================================================

:exit
EXIT /B 0

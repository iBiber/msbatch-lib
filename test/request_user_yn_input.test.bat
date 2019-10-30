@echo off
REM Interviewing the user
call ../user_input\request_user_yn_input.bat answer_skip_clean_before_build,"Do you want to skip clean before build?"
call ../user_input\request_user_yn_input.bat answer_skip_tests,"Do you want to skip tests during the build?"
call ../user_input\request_user_yn_input.bat answer_skip_deploy,"Do you want to skip deploy after a successful build?"

REM Build maven call
set mvn_target=install
set mvn_options=
if /i '%answer_skip_clean_before_build%' == 'n' (
	set mvn_target=clean %mvn_target%
)
if /i '%answer_skip_tests%' == 'y' (
	set mvn_options=%mvn_options% -DskipTests
)
if /i '%answer_skip_deploy%' == 'n' (
	set mvn_target=%mvn_target% deploy
)

REM Execute maven call:
@echo on
mvn %mvn_target% %mvn_options% -f ./git/pom.xml
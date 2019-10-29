# Scripts and how to use them
## userinput.lib.bat
A collection of batch-file-functions to support user input.

### Function `request_user_yn_input`
This function allows you to ask a yes/no question to an user on an easy and safely manner. **The user is only able to anwser with y or n** or to abort the script, **while y is the defalut anwser** when the user hits only the enter key. The result is written into the given variable.

On this way it is easy to ask an user several questions in a batch file instead of providing tons of batch files.

#### How to use it
It contains the function `request_user_yn_input` with these parameters:
1. Return variable reference
2. Text to display

For example a script to build a module with maven, which should only compile if the user hits enter several times:
```
@echo off
REM Interviewing the user
call user_input\userinput.lib.bat request_user_yn_input answer_skip_clean_before_build,"Do you want to skip clean before build?"
call user_input\userinput.lib.bat request_user_yn_input answer_skip_tests,"Do you want to skip tests during the build?"
call user_input\userinput.lib.bat request_user_yn_input answer_skip_deploy,"Do you want to skip deploy after a successful build?"

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
```

This could be a resulting console output:
```
Do you want to skip clean before build? [y/n] (default y): n

Do you want to skip tests during the build? [y/n] (default y):

Do you want to skip deploy after a successful build? [y/n] (default y): y

mvn clean install  -DskipTests -f ./git/pom.xml
```
@echo off
title Visual Java Coding
:menu
echo.
echo    Visual Java Coding
echo ==============================
echo  1. Create new project
echo  2. Open project
echo  3. Project compilation
echo  4. Start jar file
echo  5. Help
echo.
echo  6. Exit
echo.
echo  version 1.0
echo  by FernaL
echo ==============================
echo.
set /p choice=Choose option (1/2/3/4): 

if %choice%==1 (
	cls
	goto new_project
)

if %choice%==2 (
	cls
	goto open_project
)

if %choice%==3 (
	cls
	goto compilation_project
)

if %choice%==4 (
	cls
	goto start_jar
)

if %choice%==5(
	cls
	goto help
)

if %choice%==6 (
	exit
)

echo Wrong choise, try again.
cls
goto menu

:help
:: Title of function :Help
echo.
echo              Help
echo ==============================
echo.
echo 1. Functions
echo 2. Creator
echo 3. Updates
echo 4. VJC
echo.
echo ==============================

:new_project
:: Title of function :new project
echo.
echo      Creating new project
echo ==============================
echo  Write a name of your project
echo ==============================
echo.
set /p ProjectName=Write name of your project: 

:: Creating a new folder (Projects) if not exist.
if not exist Projects (
	mkdir Projects
)

cd Projects 

if "%ProjectName%"=="" (
	echo.
	echo              ERROR
    echo ===================================
	echo Name of the project can't be empty!
	echo ===================================
	echo.
    pause
	cls
    goto new_project
)

if exist "%ProjectName%" (
	echo.
	echo                ERROR
    echo ====================================
	echo Project with this name already exist
	echo ====================================
	echo.
	pause
	cls
	cd ..
	goto new_project
)

mkdir %ProjectName%
cd %ProjectName%
mkdir bin
mkdir src

echo public class Main { > src\Main.java
echo     public static void main(String[] args) { >> src\Main.java
echo         System.out.println("Hello, world!"); >> src\Main.java
echo     } >> src\Main.java
echo } >> src\Main.java

cd ..\..
cls 

echo.
echo           TASK COMPLITED
echo ==================================
echo %ProjectName% created successfully
echo ==================================
echo.

pause
cls
goto menu

:compilation_project
cls

echo.
echo        PROJECT COMPILATION
echo ==================================
echo Choose the project write name of
echo project
echo ==================================
dir
echo.

set /p ProjectName=Write the name of the project for compilation: 

if "%ProjectName%"=="" (
    echo.
    echo                ERROR
    echo ====================================
    echo Not a correct project name. . .
    echo ====================================
    echo.
    pause
    cls
    goto menu
)

if not exist "Projects\%ProjectName%" (
    echo.
    echo                ERROR
    echo ====================================
    echo Project doesn't exist
    echo ====================================
    echo.
    pause
    cls
    goto menu
)

cd "Projects\%ProjectName%" >nul 2>nul

if not exist src (
    echo.
    echo                ERROR
    echo ====================================
    echo Folder src doesn't exist
    echo ====================================
    echo.
    pause
    cd ..\..
    cls
    goto menu
)


echo.
echo        PROJECT COMPILATION
echo ==================================
echo Wait for compilation. . .
echo ==================================
echo.

javac -d bin src\*.java

if %errorlevel% neq 0 (	
	echo.
	echo                ERROR
    echo ====================================
	echo You have some errors in your code
	echo check it, and try compilation again
	echo Maybe you don't have any java class
	echo in folder src!
	echo ====================================
	echo.
	
	pause
	cd ..\..
	cls
	goto menu
)

echo.
echo             TASK COMPLITED
echo ====================================
echo Compilation into .class successfully
echo next will be compilation in jar file
echo ====================================
echo.

if not exist bin\manifest.mf (
    echo.
	echo          CREATING MANIFEST
	echo ====================================
	echo You don't have manifest but now we
	echo creating manifest, don't worry. . .
	echo ====================================
	echo.
	
    echo Manifest-Version: 1.0 > bin\manifest.mf
    echo Main-Class: Main >> bin\manifest.mf
)

set jar_path=%cd%\%ProjectName%.jar

if exist "%jar_path%" (
    echo.
	echo               ERROR
	echo ====================================
	echo Jar file is already was exist
	echo We will change it on new!
	echo ====================================
	echo.
	
	pause
	cls
	cd ..\..
	goto menu
)
echo.
echo             TASK COMPLITED
echo ====================================
echo Jar file was compilated in folder
echo "%jar_path%", check your jar file!
echo ====================================
echo.
jar cmf bin\manifest.mf "%jar_path%" -C bin .

if %errorlevel% neq 0 (
	echo.
	echo                ERROR
    echo ====================================
	echo You have some errors in your code
	echo check it, and try compilation again
	echo Maybe you don't have any java class
	echo in folder src!
	echo ====================================
	echo.
	
    pause
	cls
    cd ..\..
    goto menu
)

echo.
echo             TASK COMPLITED
echo ====================================
echo Compilation into .jar successfully
echo check folder of your project!
echo ====================================
echo.

pause
cls
cd ..\..
goto menu

:start_jar
cls
echo.
echo          JAR FILE START
echo ==================================
echo Write name of project what will be
echo started.
echo ==================================
echo.

set /p ProjectName=Write the name of project for starting jar file: 

if not exist Projects\%ProjectName% (
    echo.
    echo                ERROR
    echo ====================================
    echo Project isn't exist
    echo ====================================
    echo.
	
    pause
    cls
    goto menu
)

cd Projects\%ProjectName%

if not exist src (
    echo.
    echo                ERROR
    echo ====================================
    echo Folder src isn't exist
    echo ====================================
    echo.
	
    pause
    cd ..\..
    cls
    goto menu
)

set jar_path=%cd%\%ProjectName%.jar

if not exist "%jar_path%" (
    echo.
    echo                ERROR
    echo ====================================
    echo Jar file doesn't exist
    echo ====================================
    echo.
    pause
    cd ..\..
    cls
    goto menu
)

java -jar "%jar_path%"

if %errorlevel% neq 0 (
    echo.
    echo                ERROR
    echo ====================================
    echo Error with jar file, check your code
    echo Maybe you don't have a valid JAR file. . .
    echo ====================================
    echo.
    pause
    cls
    goto menu
)

echo.
echo             TASK COMPLITED
echo ====================================
echo Jar file successfully started!
echo ====================================
echo.

pause
cd ..\..
cls
goto menu



:open_project
echo Opening project menu. . .
:: Здесь добавим логику для открытия проекта
pause
cls
goto menu
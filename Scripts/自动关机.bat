::Script for Timed Shutdown
@echo off
@setlocal
@title 定时关机
@mode con cols=60 lines=24
::@color 1f
@cls
@set TimeGoal=20:30

@echo.
@echo.
@echo.
@echo ********************默认关机时间为:%TimeGoal%********************
@echo.
@echo.
@echo.
@echo ********************当前系统时间为:%time:~0,5%********************
@echo.
@echo.
@echo.
@choice /c ync /n /m "***按是(Y)默认时间关机 否(N)修改关机时间 取消(C)退出程序***"
@if %errorlevel%==1 goto default
@if %errorlevel%==2 goto modify
@if %errorlevel%==3 goto exit
)

:modify
@echo 时间使用24小时制，小时和分钟请用空格或.隔开，比如20.30
@set /p "TimeGoal= 请输入关机时间:"

:default
@for /f "tokens=1,2,3 delims=:" %%a in ("%time%") do @(
@set HourNow=%%a
@set MiniteNow=%%b
@set SecondNow=%%c
)
@set /a MinitesCount=%HourNow%*60 + %MiniteNow%

@for /f "tokens=1,2 delims=:,. " %%a in ("%TimeGoal%") do @(
@set HourGoal=%%a
@set MiniteGoal=%%b
)
@set /a MinitesGoal=%HourGoal%*60 + %MiniteGoal%
@set /a ShutdownTime=%MinitesGoal% - %MinitesCount%

if %ShutdownTime% LEQ 0 ( 
@echo 设置为明天关机
@set /a ShutdownTime=86400 + %ShutdownTime%*60
) else (
@set /a ShutdownTime=%ShutdownTime%*60
)

@shutdown /s /t %ShutdownTime%
@echo 电脑将在%TimeGoal%即%ShutdownTime%秒后自动关闭
@goto exit

:exit
@echo.
@echo 3秒后退出此对话框
@choice /t 3 /d y >nul

@endlocal
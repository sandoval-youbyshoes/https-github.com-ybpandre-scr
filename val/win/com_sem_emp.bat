FOR /F %%I IN ('mysql.exe -u TI  -psenhadoSQL1 -h 10.0.254.45 YouHist -e "Select Valor from paramsrelats Where Param='Atualizando'"') DO SET atualizando=%%I

IF "%atualizando%"=="SIM" (
    echo msgbox "Eval Rodando!" > "popup.vbs"
    wscript.exe "popup.vbs"
    EXIT
    )
for /f "delims=" %%a in ('wmic OS Get localdatetime  ^| find "."') do set dt=%%a
set YYYY=%dt:~0,4%
set MM=%dt:~4,2%
set DD=%dt:~6,2%
set "dnome=%YYYY%-%MM%-%DD%"

For /f %%# In ('WMIC Path Win32_LocalTime Get DayOfWeek^|Findstr [1-7]') Do ( 
    Set DOW=%%#)

if %DOW% GTR 3 (
    mysql.exe -u TI  -psenhadoSQL1 -h 10.0.254.45 YouHist -e "UPDATE paramsrelats SET Valor='SIM' WHERE Param='SemanaIncompleta'"
) ELSE (
    mysql.exe -u TI  -psenhadoSQL1 -h 10.0.254.45 YouHist -e "UPDATE paramsrelats SET Valor='NAO' WHERE Param='SemanaIncompleta'"    
)

vstudio.exe -project "G:\Meu Drive\Giros\dados\YouHistSQL\HistYou.vsp" -make_new_report "CompSemanal_emp_auto" -datasource "mysql://host = '10.0.254.45' port = '3306' dbname = 'youhist' user = 'TI' password = 'senhadoSQL1' timeout = '60000'" -print_to_disk "C:\rel\CompSemanal-EMP-%dnome%.pdf" -format kTopdf
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



call vstudio.exe -project "G:\Meu Drive\Giros\dados\YouHistSQL\HistYou.vsp" -make_new_report "FastMovers_auto" -datasource "mysql://host = '10.0.254.45' port = '3306' dbname = 'youhist' user = 'TI' password = 'senhadoSQL1' timeout = '60000'" -print_to_disk "C:\rel\FastMovers-%dnome%.ps" -format kToPostscript
call ps2pdf -dOptimize#true -dUseFlateCompression#true -dPDFSETTINGS#/printer C:\rel\FastMovers-%dnome%.ps C:\rel\FastMovers-%dnome%.pdf
call del C:\rel\FastMovers-%dnome%.ps
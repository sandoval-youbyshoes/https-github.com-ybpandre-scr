FOR /F %%I IN ('mysql.exe -u TI  -psenhadoSQL1 -h 192.168.68.37 YouHist -e "Select Valor from paramsrelats Where Param='Atualizando'"') DO SET atualizando=%%I

IF "%atualizando%"=="SIM" (
    echo msgbox "Eval Rodando!" > "popup.vbs"
    wscript.exe "popup.vbs"
    EXIT
    )
for /f "delims=" %%a in ('wmic OS Get localdatetime  ^| find "."') do set dt=%%a
set YYYY=%dt:~0,4%
set MM=%dt:~4,2%
set DD=%dt:~6,2%
set "dnome=%YYYY%%MM%%DD%"

FOR /F %%l IN ('mysql.exe -N -u TI  -psenhadoSQL1 -h 192.168.68.37 YouHist -e "select distinct local from youhist.gerapromo"') DO (

mysql.exe -u TI  -psenhadoSQL1 -h 192.168.68.37 YouHist -e "UPDATE paramsrelats SET Valor='%%l' WHERE Param='LocalC'"
vstudio.exe -project "G:\Meu Drive\Giros\dados\YouHistSQL\HistYou.vsp" -make_new_report "Promos" -datasource "mysql://host = '192.168.68.37' port = '3306' dbname = 'youhist' user = 'TI' password = 'senhadoSQL1' timeout = '60000'" -print_to_disk "C:\rel\%%l.ps" -format kToPostscript
ps2pdf -dOptimize#true -dUseFlateCompression#true -dPDFSETTINGS#/printer C:\rel\%%l.ps C:\rel\%%l.pdf
del C:\rel\%%l.ps
)
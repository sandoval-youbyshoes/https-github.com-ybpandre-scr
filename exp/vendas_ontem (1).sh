ontem=$(date -d "yesterday 13:00" '+%Y-%m-%d')
if [ $eval == 'SIM'];
then
    echo "Eval está sendo atualizada"
    exit;
fi
mysql -u TI -psenhadoSQL1 YouHist -e "SELECT * FROM (SELECT IFNULL(SUBSTRING_INDEX(l.localc, '-', -1), 'Total') AS Loja, SUM(v.valor) AS Valor, SUM(v.quantidade) AS Pares FROM vendas v INNER JOIN locais l ON l.LocalM = v.Local WHERE data = '$ontem' AND local != 'ES 01 CD' GROUP BY l.localc WITH ROLLUP ) AS tmp ORDER BY FIELD(tmp.loja, 'Total') ASC, tmp.valor DESC;" > vendas_ontem.txt

awk '
        BEGIN {
                print "From: sistema@youbyshoes.com.br"
                print "To: logistica@youbyshoes.com.br"
                print "Cc: t.i@youbyshoes.com.br"
                print "Cc: humberto@youbyshoes.com.br"
                print "Cc: telma@youbyshoes.com.br"
                print "Cc: tatiana@youbyshoes.com.br"
                print "MIME-Version: 1.0"
                print "Content-Type: text/html"
                print "Subject: Vendas Ontem Liquido"
                print "<html><body>"
                print "<table border=1 cellspacing=2 cellpadding=2>"
        }
        !/^#/ && /^S/ {
                print "<tr>"
                for ( i = 1; i <= NF; i++ )
                        print "<td>" $i "</td>"
                print "</tr>"
        }
        !/^#/ && !/^S/ {
                print "<tr>"
                for ( i = 1; i <= NF; i++ )
                        print "<td>" $i "</td>"
                print "</tr>"
        }
        END {
                print "</table></body></html>"
        }
' vendas_ontem.txt | /usr/sbin/sendmail -t

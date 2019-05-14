ontem=$(date -d "yesterday 13:00" '+%Y-%m-%d')
# destinatarios='humberto@youbyshoes.com.br, telma@youbyshoes.com.br, tatiana@youbyshoes.com.br, logistica@youbyshoes.com.br, t.i@youbyshoes.com.br'
# mysql -u TI -psenhadoSQL1 YouHist -t -e "SELECT local, sum(valor) as Valor, sum(quantidade) as quant FROM vendas where data = '$ontem' group by 1 order by Valor desc" | mutt -s 'Vendas ontem' -- $destinatarios

mysql -u TI -psenhadoSQL1 YouHist -e "SELECT * FROM (SELECT IFNULL(SUBSTRING_INDEX(l.localc, '-', -1), 'Total') AS Loja, SUM(v.valor) AS Valor, SUM(v.quantidade) AS Pares FROM vendas v INNER JOIN locais l ON l.LocalM = v.Local WHERE data = '$ontem' AND quantidade > 0 GROUP BY l.localc WITH ROLLUP ) AS tmp ORDER BY FIELD(tmp.loja, 'Total') ASC, tmp.valor DESC;" > vendas_ontem.txt

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
                print "Subject: Vendas Ontem Bruto"
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
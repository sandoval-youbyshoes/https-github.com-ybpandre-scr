#!/bin/bash

if [ "$#" -ne 5 ]; then
    echo "Illegal number of parameters"
    exit 0
fi


psql -h $1 -d $2 -U $3 -f "$4/champions.sql" -o "$5/champions.csv"
psql -h $1 -d $2 -U $3 -f "$4/clients.sql" -o "$5/clients.csv"
psql -h $1 -d $2 -U $3 -f "$4/companies.sql" -o "$5/companies.csv"
#psql -h $1 -d $2 -U $3 -f "$4/quants.sql" -o "$5/quants.csv"
psql -h $1 -d $2 -U $3 -f "$4/moves.sql" -o "$5/moves.csv"
psql -h $1 -d $2 -U $3 -f "$4/payments.sql" -o "$5/payments.csv"
psql -h $1 -d $2 -U $3 -f "$4/prices.sql" -o "$5/prices.csv"
psql -h $1 -d $2 -U $3 -f "$4/products.sql" -o "$5/products.csv"
psql -h $1 -d $2 -U $3 -f "$4/stock_history.sql" -o "$5/stock_history.csv"
psql -h $1 -d $2 -U $3 -f "$4/targets.sql" -o "$5/targets.csv"

#10.132.37.208
#youbyshoes
#youbyshoes
#/opt/odoo/prod_erp/var/export/sql_views/
#/opt/scripts_sql

OUT="$HOME/TCC_USP/results_sqli/2db_seguro_tables.txt"

{
echo "== TABLES IN db_seguro =="
date
echo
sudo mysql -D db_seguro -e "SHOW TABLES;"
} | tee "$OUT"

echo
echo "== FILE SAVED =="
ls -lh "$OUT"

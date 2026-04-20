OUT="$HOME/TCC_USP/results_sqli/5show_grants_users.txt"

{
echo "== SHOW GRANTS FOR APPLICATION USERS =="
date
echo

echo "[app_seguro]"
sudo mysql -N -e "SHOW GRANTS FOR 'app_seguro'@'localhost';"
echo

echo "[app_inter]"
sudo mysql -N -e "SHOW GRANTS FOR 'app_inter'@'localhost';"
echo

echo "[app_vuln]"
sudo mysql -N -e "SHOW GRANTS FOR 'app_vuln'@'localhost';"
} | tee "$OUT"

echo
echo "== FILE SAVED =="
ls -lh "$OUT"

mkdir -p "$HOME/TCC_USP/results_sqli"

OUT="$HOME/TCC_USP/results_sqli/1mysql_audit.txt"

{
  echo "== LOCAL MYSQL AUDIT =="
  date
  echo

  echo "[VERSION]"
  sudo mysql -N -e "SELECT VERSION();"
  echo

  echo "[bind_address]"
  sudo mysql -N -e "SHOW VARIABLES LIKE 'bind_address';"
  echo

  echo "[port]"
  sudo mysql -N -e "SHOW VARIABLES LIKE 'port';"
  echo

  echo "[local_infile]"
  sudo mysql -N -e "SHOW VARIABLES LIKE 'local_infile';"
  echo

  echo "[secure_file_priv]"
  sudo mysql -N -e "SHOW VARIABLES LIKE 'secure_file_priv';"
  echo

  echo "[sql_mode]"
  sudo mysql -N -e "SHOW VARIABLES LIKE 'sql_mode';"
} | tee "$OUT"

echo
echo "== FILE SAVED =="
ls -lh "$OUT"

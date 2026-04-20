OUT="$HOME/TCC_USP/results_sqli/4table_count_across_schemas.txt"

{
  echo "== TABLE COUNTS ACROSS SCHEMAS =="
  date
  echo
  sudo mysql -N -e "
    SELECT table_schema, COUNT(*) AS total_tables
    FROM information_schema.tables
    WHERE table_schema IN ('db_seguro','db_intermediario','db_simulado_vulneravel')
    GROUP BY table_schema
    ORDER BY table_schema;
  "
} | tee "$OUT"

echo
echo "== FILE SAVED =="
ls -lh "$OUT"

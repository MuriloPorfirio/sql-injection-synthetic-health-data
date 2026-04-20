OUT="$HOME/TCC_USP/results_sqli/3patients_count_across_schemas.txt"

{
  echo "== PATIENT COUNTS ACROSS SCHEMAS =="
  date
  echo
  sudo mysql -N -e "
    SELECT 'db_seguro' AS schema_name, COUNT(*) AS total_patients FROM db_seguro.patients
    UNION ALL
    SELECT 'db_intermediario' AS schema_name, COUNT(*) AS total_patients FROM db_intermediario.patients
    UNION ALL
    SELECT 'db_simulado_vulneravel' AS schema_name, COUNT(*) AS total_patients FROM db_simulado_vulneravel.patients;
  "
} | tee "$OUT"

echo
echo "== FILE SAVED =="
ls -lh "$OUT"

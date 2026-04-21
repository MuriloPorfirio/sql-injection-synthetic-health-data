cd /home/muriloporfirio/TCC_USP/pacientes/csv
rm -f /tmp/create_*.sql /tmp/create_all_staging.sql

for f in *.csv; do
  t="${f%.csv}"
  header=$(head -n1 "$f" | tr -d '\r')
  {
    echo "DROP TABLE IF EXISTS \`${t}\`;"
    echo "CREATE TABLE \`${t}\` ("
    echo "$header" | awk -F',' '{
      for (i=1; i<=NF; i++) {
        col=$i; gsub(/[^A-Za-z0-9_]/,"_",col);
        sep = (i<NF) ? "," : "";
        printf "  `%s` TEXT%s\n", tolower(col), sep
      }
    }'
    echo ") ENGINE=InnoDB ROW_FORMAT=DYNAMIC DEFAULT CHARSET=utf8mb4;"
  } > "/tmp/create_${t}.sql"
done

cat /tmp/create_*.sql > /tmp/create_all_staging.sql
sudo mysql -u root db_seguro < /tmp/create_all_staging.sql

sudo mysql -u root -e "SHOW TABLES IN db_seguro;"

for f in /home/muriloporfirio/TCC_USP/pacientes/csv/*.csv; do
  t=$(basename "$f" .csv)
  echo "Importando $t ..."
  sudo mysql --local-infile=1 -u root db_seguro -e "
    LOAD DATA LOCAL INFILE '$(realpath "$f")'
    INTO TABLE ${t}
    FIELDS TERMINATED BY ',' ENCLOSED BY '\"'
    LINES TERMINATED BY '\n'
    IGNORE 1 LINES;
  "
done

echo "Importação concluída."
sudo mysql -u root -e "SELECT COUNT(*) AS pacientes FROM db_seguro.patients;"

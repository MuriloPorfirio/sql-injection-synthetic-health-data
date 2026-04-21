sudo mysqldump -u root --no-data db_seguro | sudo mysql -u root db_intermediario
sudo mysqldump -u root --no-data db_seguro | sudo mysql -u root db_simulado_vulneravel
sudo mysqldump -u root --no-create-info db_seguro | sudo mysql -u root db_intermediario
sudo mysqldump -u root --no-create-info db_seguro | sudo mysql -u root db_simulado_vulneravel

echo "Clonagem concluída."

sudo mysql -u root -e "
SELECT 'db_seguro' as db,   (SELECT COUNT(*) FROM db_seguro.patients) AS patients_count
UNION ALL
SELECT 'db_intermediario', (SELECT COUNT(*) FROM db_intermediario.patients)
UNION ALL
SELECT 'db_simulado_vulneravel', (SELECT COUNT(*) FROM db_simulado_vulneravel.patients);

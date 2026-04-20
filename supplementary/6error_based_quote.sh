OUT="$HOME/TCC_USP/results_sqli/6error_based_quote.txt"

{
echo "== ERROR-BASED SQLI TEST =="
date
echo
curl -i --max-time 10 "http://127.0.0.1:5000/buscar?q=%27
" 2>&1 | sed -n '1,40p'
} | tee "$OUT"

echo
echo "== FILE SAVED =="
ls -lh "$OUT"

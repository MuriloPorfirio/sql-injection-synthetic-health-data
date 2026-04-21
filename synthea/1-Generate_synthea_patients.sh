OUT="/home/muriloporfirio/TCC_USP/pacientes"
JAR="$HOME/synthea-cli/synthea-with-dependencies.jar"

# cria pasta de saída e baixa o jar se ainda não existir
mkdir -p "$OUT" "$HOME/synthea-cli"
[ -f "$JAR" ] || wget -O "$JAR" \
  https://github.com/synthetichealth/synthea/releases/download/master-branch-latest/synthea-with-dependencies.jar

# gera 300 pacientes e exporta apenas CSV
java -jar "$JAR" \
  -p 300 \
  --exporter.csv.export true \
  --exporter.fhir.export false \
  --exporter.baseDirectory "$OUT"

# verifica os arquivos gerados
ls -la "$OUT"/csv | head -n 20

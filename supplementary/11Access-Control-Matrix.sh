import pandas as pd
import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt
from matplotlib.colors import ListedColormap

dados = {
    'Operação SQL Testada': [
        '1. UPDATE (Tabela)', 
        '2. DELETE (Tabela)', 
        '3. CREATE TEMP TABLE', 
        '4. CREATE TABLE (Perm)'
    ],
    'app_seguro': [1, 0, 0, 0],
    'app_inter':  [1, 1, 1, 0],
    'app_vuln':   [1, 1, 1, 1]
}

df = pd.DataFrame(dados).set_index('Operação SQL Testada')

sns.set_theme(style="white", font_scale=1.1)
plt.rcParams["font.family"] = "sans-serif"
plt.figure(figsize=(9.5, 5.5))

cmap = ListedColormap(['#C0392B', '#2980B9'])

ax = sns.heatmap(df, annot=True, cmap=cmap, cbar=False,
                 linewidths=3, linecolor='white')

for t in ax.texts:
    valor = float(t.get_text())
    if valor == 1.0:
        t.set_text("VULNERÁVEL\n(Explorado)")
        t.set_color("white")
        t.set_weight("bold")
        t.set_fontsize(11)
    else:
        t.set_text("PROTEGIDO\n(Mitigado)")
        t.set_color("white")
        t.set_weight("bold")
        t.set_fontsize(11)

plt.xlabel("Cenário de Execução (Perfil de Privilégio)", fontsize=12, labelpad=15, color="#34495E", fontweight='bold')
plt.ylabel("Operação no Banco de Dados", fontsize=12, labelpad=15, color="#34495E", fontweight='bold')

plt.xticks(fontsize=12, color="#2C3E50")
plt.yticks(fontsize=11, rotation=0, color="#2C3E50")

ax.tick_params(left=False, bottom=False)

plt.tight_layout()
plt.show()

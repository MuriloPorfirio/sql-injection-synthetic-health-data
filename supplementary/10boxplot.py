import pandas as pd
import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt
from matplotlib.ticker import FuncFormatter

np.random.seed(42)
dados_experimentais = []

stats = {
    ('app_seguro', 'baseline'): (0.048975, 0.006539),
    ('app_seguro', 'time_false'): (0.083929, 0.014872),
    ('app_seguro', 'time_true'): (2.065452, 0.020137),
    ('app_inter', 'baseline'): (0.057686, 0.025458),
    ('app_inter', 'time_false'): (0.075352, 0.030144),
    ('app_inter', 'time_true'): (2.079407, 0.018749),
    ('app_vuln', 'baseline'): (0.063748, 0.022005),
    ('app_vuln', 'time_false'): (0.066562, 0.019762),
    ('app_vuln', 'time_true'): (2.088090, 0.014309),
}

for (cenario, tipo), (media, std) in stats.items():
    valores = np.random.normal(media, std, 30)
    for v in valores:
        dados_experimentais.append({'Cenário': cenario, 'Condição': tipo, 'Tempo (s)': max(v, 0.01)})

df = pd.DataFrame(dados_experimentais)

sns.set_theme(style="ticks", font_scale=1.1)
plt.rcParams["font.family"] = "sans-serif"
plt.figure(figsize=(10, 5.5)) 

cores = {"baseline": "#EAEAEA", "time_false": "#A6A6A6", "time_true": "#C0392B"}

ax = sns.boxplot(
    x="Cenário", y="Tempo (s)", hue="Condição", data=df,
    palette=cores, width=0.6, linewidth=1.2, fliersize=3,
    showmeans=True, 
    meanprops={"marker":"o", "markerfacecolor":"white", "markeredgecolor":"#333333", "markersize":"5"},
    boxprops={"edgecolor": "#333333", "alpha": 0.95},
    whiskerprops={"color": "#333333"},
    capprops={"color": "#333333"},
    medianprops={"color": "#333333", "linewidth": 1.5}
)

ax.set_yscale("log")

ax.set_ylim(0.02, 5.0) 

ax.yaxis.set_major_formatter(FuncFormatter(lambda y, _: '{:g}'.format(y)))
ax.set_yticks([0.03, 0.05, 0.1, 0.2, 0.5, 1.0, 2.0, 4.0]) 

ax.yaxis.grid(True, linestyle='--', color='#D3D3D3', alpha=0.7)
ax.xaxis.grid(False)
sns.despine(offset=10, trim=False)

plt.xlabel("Cenário de Execução", fontsize=12, labelpad=12, color="#34495E")
plt.ylabel("Tempo Total (segundos) — Escala Log", fontsize=12, labelpad=12, color="#34495E")

for i in range(3):
    plt.text(i + 0.26, 3.0, "***", ha='center', va='center', color='#C0392B', fontsize=12, fontweight='bold')

handles, labels = ax.get_legend_handles_labels()
ax.legend(handles=handles, labels=["Baseline (Legítima)", "Time False (Sem atraso)", "Time True (Com atraso)"],
          title=None, loc='upper center', bbox_to_anchor=(0.5, 1.05), ncol=3, frameon=False, fontsize=11)

plt.tight_layout()
plt.show()

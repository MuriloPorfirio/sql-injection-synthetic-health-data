# SQL Injection in Synthetic Health Data

> Repositório de apoio ao TCC **“Vulnerabilidades em Sistemas de Saúde Digital: Injeções SQL com Dados Sintéticos”**.

## Visão geral

Este repositório documenta um experimento controlado de **SQL Injection em ambiente local e isolado**, utilizando **dados clínicos sintéticos** gerados com **Synthea** e carregados em múltiplos schemas MySQL equivalentes.

A proposta central do estudo é simples e importante: **medir como o perfil de privilégios do usuário da aplicação altera o impacto real de uma vulnerabilidade SQL Injection**, mesmo quando a falha na aplicação é a mesma.

---

## Objetivo

Avaliar, em ambiente controlado, como diferentes **perfis de privilégio no banco de dados** influenciam a:

- **exploração** de falhas de SQL Injection;
- **enumeração** de metadados e estrutura do banco;
- **exfiltração** de dados sintéticos;
- **capacidade de alteração** lógica e estrutural do banco.

---

## Ideia do experimento

O desenho experimental foi construído com três princípios:

1. **Mesma aplicação vulnerável**
2. **Mesmo conjunto de dados sintéticos**
3. **Diferença apenas no nível de privilégio do usuário no MySQL**

Com isso, foi possível isolar o efeito do **controle de acesso** sobre o risco operacional da vulnerabilidade.

### Cenários avaliados

| Cenário | Schema | Usuário | Perfil de acesso |
|---|---|---|---|
| Seguro | `db_seguro` | `app_seguro` | `SELECT`, `INSERT`, `UPDATE` |
| Intermediário | `db_intermediario` | `app_inter` | `SELECT`, `INSERT`, `UPDATE`, `DELETE`, `CREATE TEMPORARY TABLES` |
| Vulnerável | `db_simulado_vulneravel` | `app_vuln` | `ALL PRIVILEGES` |

---

## Ambiente utilizado

- **Sistema operacional:** Linux Mint / base Ubuntu 24.04 LTS  
- **Python:** 3.12.3  
- **Flask:** 3.1.3  
- **MySQL Community Server:** 8.0.45  
- **Driver MySQL para Python:** `mysql-connector-python` 9.6.0  
- **Gerador de dados sintéticos:** Synthea  

O ambiente foi mantido em **execução local**, com o MySQL acessível apenas via loopback (`127.0.0.1`) durante a fase auditada do experimento.

---

## Dados sintéticos

Os dados foram gerados com **Synthea** e organizados a partir de exportação em CSV para ingestão relacional.

### Base experimental

- **18 arquivos CSV** sintéticos
- **349 registros** na tabela `patients`
- **3 schemas equivalentes** para comparação controlada
- **19 tabelas por schema** no ambiente final, incluindo a tabela experimental `exp_impacto`

> Em outras palavras: o conteúdo clínico sintético foi mantido equivalente entre os cenários, e o que mudou foi apenas o **nível de privilégio** concedido ao usuário da aplicação.

---

## Estrutura do repositório

```text
.
├── supplementary/
│   ├── 1mysql_audit.sh / 1mysql_audit.txt
│   ├── 2db_seguro_tables.sh / 2db_seguro_tables.txt
│   ├── 3patients_count_across_schemas.sh / 3patients_count_across_schemas.txt
│   ├── 4table_count_across_schemas.sh / 4table_count_across_schemas.txt
│   ├── 5show_grants_users.sh / 5show_grants_users.txt
│   ├── 6error_based_quote.sh / 6error_based_quote.txt
│   ├── 7app_seguro_boolean_true.sh / 7app_seguro_boolean_true.html
│   ├── 8app_seguro_union_tables_and_app_seguro_union_columns_patients.sh
│   ├── 8app_seguro_union_tables.html
│   ├── 8app_seguro_union_columns_patients.html
│   ├── 9app_seguro_union_exfil_patients.sh
│   ├── 9app_seguro_union_exfil_patients.html
│   ├── 10boxplot.py
│   └── 11Access-Control-Matrix.sh
│
├── synthea/
│   ├── 1-Generate_synthea_patients.sh
│   ├── 2-18_staging_tables_creation.sh
│   ├── 3-Activate_LOAD_DATA_LOCAL.sh
│   ├── 4-import_CSVs_on_databank.sh
│   ├── 5-Triplicate-databank.sh
│   └── Synthetic-clinical-annotations-CSVs.zip
│
└── README.md

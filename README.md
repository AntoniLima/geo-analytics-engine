# **geo-analytics-engine - Pipeline de ingestão**
Aplicação modular para ingestão de planilhas (CSV/Excel), geocodificação automática e análise de distância espacial entre cidades e polos.

![Status](https://img.shields.io/badge/status-em%20desenvolvimento-yellow)
![Python](https://img.shields.io/badge/python-3.11-blue)
![Cloud](https://img.shields.io/badge/cloud-AWS-orange)
![Fonte](https://img.shields.io/badge/fonte-BigQuery-4285F4)
![IaC](https://img.shields.io/badge/IaC-Terraform-7B42BC)
![Qualidade](https://img.shields.io/badge/qualidade-8%2F8%20aprovadas-brightgreen)
![License](https://img.shields.io/badge/license-MIT-green)

> **Documentação:** este README apresenta para o projeto: arquitetura, decisões, execução.

---

## Sumário

## 1. Ideia

A ideia é criar uma solução que gere uma análise e traga as distâncias baseando-se na cidade de origem e destino.

## 2. Fonte dos dados

Os dados são de origem propria de quem utilizar, a pessoa deverá realizar o input dos dados através de uma planilha em excel ou um arquivo csv.



## 4. Arquitetura
´´´mermaid
flowchart TD
    subgraph INGESTAO["1. Ingestão & Upload"]
        A["Arquivo do Usuário<br/>(.xlsx, .xls ou .csv)"] --> B{"Detector de Formato & Delimitador"}
        B -->|CSV com Vírgula ','| C1["Parser Pandas sep=','"]
        B -->|CSV com Pipe '|'| C2["Parser Pandas sep='|'"]
        B -->|Planilha Excel| C3["Parser OpenPyXL"]
    end

    subgraph PREP["2. Limpeza & Deduplicação"]
        C1 & C2 & C3 --> D["Validador de Schema:<br/>[UF, Cidade, Polo]"]
        D --> E["Sanitização de Strings<br/>(Trim, Upper, Normalização de Acentos)"]
        E --> F["Extração de Pares Únicos<br/>(Cidade/UF ↔ Polo)"]
    end

    subgraph GEO["3. Motor de Geocoding & Confronto"]
        F --> G["Cache Local de Coordenadas<br/>(SQLite / Memória / Base IBGE)"]
        G --> H{"Coordenadas no Cache?"}
        H -->|Sim| I["Recupera Lat/Long"]
        H -->|Não| J["Geocodificador<br/>(Geopy / Nominatim / Google Maps)"]
        J --> K["Grava no Cache"]
        I & K --> L["Cálculo de Distância:<br/>• Haversine (Linha Reta / km)<br/>• OSRM (Malha Rodoviária / km)"]
    end

    subgraph UI_EXPORT["4. Visualização & Exportação"]
        L --> M["Merge com a Base Original"]
        M --> N["Dashboard Interativo (Streamlit)"]
        N --> O["Mapa Geoespacial<br/>(Pinos + Linhas de Rota)"]
        N --> P["Tabela com Filtros & KPIs<br/>(Distância Média, Mín, Máx)"]
        N --> Q["Download dos Resultados<br/>(.xlsx / .csv tratado)"]
    end

    style INGESTAO fill:#131b2e,stroke:#38bdf8,stroke-width:2px,color:#f8fafc
    style PREP fill:#131b2e,stroke:#a855f7,stroke-width:2px,color:#f8fafc
    style GEO fill:#131b2e,stroke:#f97316,stroke-width:2px,color:#f8fafc
    style UI_EXPORT fill:#131b2e,stroke:#10b981,stroke-width:2px,color:#f8fafc
´´´

## 5. Roadmap e status

| Etapa        | Entregável   | Status |
| Em definição | Em definição |⏳      |


## 6. Licença

Distribuído sob a licença MIT. Veja [LICENSE](LICENSE).
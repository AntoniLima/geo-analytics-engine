#!/usr/bin/env bash
PROJECT_NAME="geo-analytics-engine"

# 1. Criação das pastas
mkdir -p "$PROJECT_NAME"/{data/{raw,processed,cache},src,tests}

# 2. Criação dos arquivos vazios
touch "$PROJECT_NAME"/src/{__init__.py,ingestion.py,geocoding.py,distance.py,components.py}
touch "$PROJECT_NAME"/tests/{__init__.py,test_ingestion.py,test_distance.py}
touch "$PROJECT_NAME"/{.env.example,.gitignore,app.py,Dockerfile,Makefile,requirements.txt,README.md}

echo "Estrutura criada em: ./$PROJECT_NAME"
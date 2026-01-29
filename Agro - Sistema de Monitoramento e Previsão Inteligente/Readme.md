# 🌾 AgroForecast 2026: Previsão de Vigor Vegetativo via IA e Satélite

![Status do Projeto](https://img.shields.io/badge/Status-Conclu%C3%ADdo-brightgreen)
![Python Version](https://img.shields.io/badge/Python-3.9+-blue)
![Machine Learning](https://img.shields.io/badge/ML-Random%20Forest-orange)

## 📋 Sobre o Projeto
Este projeto implementa um sistema de monitoramento e previsão de saúde da cana-de-açúcar para a região de Ribeirão Preto/SP. Utilizando dados de satélite (Sentinel-2) e dados climáticos da NASA, o modelo de Inteligência Artificial prevê o índice NDVI (vigor da planta) com 7 dias de antecedência, permitindo decisões preventivas no manejo agrícola.

### 🚀 Demonstração
> **Link para o Dashboard Interativo:** [INSIRA SEU LINK DO STREAMLIT AQUI OU REMOVA ESTA LINHA]

---

## 🛠️ Tecnologias e Fontes de Dados
* **Dados de Satélite:** Índice NDVI extraído via Sentinel-2.
* **Dados Climáticos:** NASA POWER (Temperatura, Chuva, Radiação, Umidade do Solo).
* **Linguagem:** Python 3.
* **Bibliotecas Principais:** Pandas, Scikit-Learn, Streamlit, Plotly, Joblib.
* **Algoritmo:** Random Forest Regressor.

---

## 🧠 Inteligência e Feature Engineering
O diferencial deste modelo é a criação de atributos que simulam a "memória" da planta perante o clima:
* **Janelas Móveis:** Acumulado de chuva de 15 e 30 dias (essencial para culturas de sequeiro).
* **Lags Temporais:** Médias móveis de temperatura e umidade do solo.
* **Variáveis Cíclicas:** Sazonalidade baseada no dia do ano e mês.

**Performance do Modelo:** Obtivemos um **R² Score de 0.72**, indicando uma forte aderência às variações reais de campo.

---

## 🖥️ Arquitetura do Sistema
O projeto foi estruturado em duas camadas:
1.  **Pipeline de Treinamento:** Notebook documentado com a análise exploratória, tratamento de dados e validação do modelo.
2.  **Camada de Entrega (App):** Dashboard desenvolvido em Streamlit que atua como um **Agente Agrônomo**, fornecendo não apenas o gráfico, mas recomendações técnicas automáticas baseadas nas previsões.

---

## 📦 Como Executar
1. Clone o repositório:
   ```bash
   git clone [https://github.com/seu-usuario/projeto-agro-2026.git](https://github.com/seu-usuario/projeto-agro-2026.git)

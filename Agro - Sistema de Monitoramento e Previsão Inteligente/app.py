import streamlit as st
import pandas as pd
import joblib
import plotly.express as px

# 1. Configurações Iniciais
st.set_page_config(page_title="AgroForecast 2026", layout="wide", page_icon="🌱")

# 2. Carregar Dados e Modelo
@st.cache_data # Cache para performance
def carregar_dados():
    df = pd.read_csv("dados_para_dashboard.csv", index_col=0, parse_dates=True)
    modelo = joblib.load("modelo_agro_treinado.pkl")
    return df, modelo

try:
    df, modelo = carregar_dados()
    
    # --- AJUSTE DE COLUNAS (A correção que precisávamos) ---
    # Pegamos as colunas exatas que o modelo exige
    colunas_do_modelo = modelo.feature_names_in_
    
    # Organizamos o dataframe para ter essas colunas na ordem correta
    # Se faltar alguma, o erro aparecerá aqui de forma clara
    X_input = df[colunas_do_modelo]
    
    # Realizando a previsão com as features corretas
    previsoes_todas = modelo.predict(X_input)
    df['previsao'] = previsoes_todas
    
    # Dados do último dia para o Agente
    ultimo_dia = df.iloc[-1]
    prev_7d = previsoes_todas[-1]
    
    # Cálculo da variação (usando o NDVI atual vs previsto)
    ndvi_atual = ultimo_dia['ndvi']
    variacao = ((prev_7d - ndvi_atual) / ndvi_atual) * 100

    # --- INTERFACE ---
    st.title("🌱 Agente Agrônomo Digital")
    st.markdown(f"**Localização:** Ribeirão Preto | **Última Atualização:** {df.index[-1].strftime('%d/%m/%Y')}")

    # Sidebar com métricas
    st.sidebar.header("Status de Campo")
    st.sidebar.metric("NDVI Atual", f"{ndvi_atual:.3f}")
    st.sidebar.metric("Previsão (7 dias)", f"{prev_7d:.3f}", f"{variacao:+.2f}%")

    col1, col2 = st.columns([2, 1])

    with col1:
        st.subheader("Série Temporal: Real vs Previsto")
        # Mostrando os últimos 100 dias para melhor visibilidade
        fig = px.line(df.tail(100), y=['ndvi', 'previsao'], 
                     labels={'value': 'Índice NDVI', 'index': 'Data'},
                     color_discrete_map={'ndvi': 'seagreen', 'previsao': 'orange'})
        
        fig.update_layout(legend_title_text='Legenda')
        st.plotly_chart(fig, use_container_width=True)

    with col2:
        st.subheader("Plano de Ação (IA Prescritiva)")
        
        # Lógica do Agente Agrônomo baseada na variação prevista
        if variacao < -2:
            st.error(f"**Alerta de Declínio:** Previsão de queda de {abs(variacao):.1f}% no vigor.")
            st.write("👉 **Recomendação:** O modelo detectou estresse hídrico ou nutricional iminente. Verifique a umidade do solo e considere irrigação suplementar.")
        elif variacao > 2:
            st.success(f"**Alerta de Crescimento:** Aumento de {variacao:.1f}% previsto.")
            st.write("👉 **Recomendação:** Condições ótimas. Ótimo momento para monitorar a taxa de crescimento e planejar a aplicação de fertilizantes de cobertura.")
        else:
            st.info("**Desenvolvimento Estável:** A cultura mantém bons índices de clorofila.")
            st.write("👉 **Recomendação:** Manter cronograma de manejo atual. Nenhuma intervenção de emergência necessária.")

except Exception as e:
    st.error(f"Erro técnico no processamento: {e}")
    st.info("Dica: Verifique se você executou a célula de exportação no seu Notebook para atualizar os arquivos CSV e PKL.")
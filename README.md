# 🎬 CineStream DB: Modelagem de Banco de Dados para Streaming

> **Status:** Concluído ✅

## 📋 Sobre o Projeto
Modelagem e implementação de um banco de dados relacional completo para uma plataforma de streaming (similar à Netflix). O projeto abrange desde a arquitetura das tabelas até a criação de relatórios analíticos de audiência.

O foco principal foi garantir a **integridade referencial** e a performance das consultas.

## 🛠 Tecnologias & Conceitos
* **SQL (PostgreSQL)**
* **Modelagem de Dados (MER):** Relacionamentos 1:N e N:N.
* **Normalização:** Estruturação para evitar redundância.
* **DDL & DML:** Criação de estruturas e manipulação de massa de dados.

## 🗂 Estrutura do Banco de Dados
O sistema gerencia as seguintes entidades:
* **Contas & Planos:** Gestão de assinaturas, vencimentos e limites de telas.
* **Perfis:** Controle individual de usuários (Kids/Adulto) dentro de uma conta.
* **Catálogo:** Filmes, Gêneros e Classificação Indicativa.
* **Histórico:** Registro de "tempo assistido" para gerar recomendações.

## 🔍 Exemplos de Queries (Relatórios)
O projeto inclui scripts SQL para responder perguntas de negócio, como:
1.  *Quais filmes foram lançados após 2020?*
2.  *Qual a receita total gerada por tipo de plano?*
3.  *Histórico de visualização por perfil de usuário.*

```sql
-- Exemplo de Query do Projeto:
SELECT titulo, ano_lancamento
FROM filmes
WHERE ano_lancamento > 2020;

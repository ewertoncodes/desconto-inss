# Desconto INSS - Guia de Instalação

## 🚀 Iniciando com Docker

🚀 Guia Rápido - Execução e Testes
▶️ Como Rodar o Projeto
Opção 1: Docker (Recomendado)

```bash
git clone git@github.com:ewertoncodes/desconto-inss.git
cd desconto-inss

# 1. Iniciar containers
docker-compose up -d --build

# 2. Configurar banco de dados
docker-compose exec web bundle exec rails db:create db:migrate db:seed
```
Acesse: http://localhost:3000

```bash
# 1. Instalar dependências
bundle install && yarn install

# 2. Configurar banco
rails db:create db:migrate db:seed

# 3. Iniciar servidor
./bin/dev
```
Acesse: http://localhost:3000
```bash
# Docker
docker-compose run -e RAILS_ENV=test web bundle exec rspec

# Local
rails db:test:prepare && rspec
```

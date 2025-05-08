ARG RUBY_VERSION=3.3.3
FROM ruby:$RUBY_VERSION-slim

ENV RAILS_ENV=development \
    BUNDLE_PATH=/usr/local/bundle \
    BUNDLE_WITHOUT=production

# Instala dependências
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    build-essential curl libpq-dev nodejs npm git && \
    npm install -g yarn && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copia arquivos de dependências primeiro (para cache)
COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile && \
    yarn add postcss autoprefixer postcss-cli nodemon sass -D

COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copia aplicação
COPY . .

# Configura diretório de assets
RUN mkdir -p app/assets/builds && \
    chmod +x ./bin/dev

EXPOSE 3000

CMD ["./bin/dev"]

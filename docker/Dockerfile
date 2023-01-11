FROM ruby:2.7.3

ENV HOME /root

ARG RAILS_ENV
ARG RAILS_RELATIVE_URL_ROOT

RUN apt-get update && apt-get install -y nginx nodejs default-mysql-client

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR /usr/src/app/igeo

COPY Gemfile Gemfile.lock ./

# Copia a aplicação em si
COPY . .

# Instala as gems
RUN gem install bundler -v '2.0.2' && bundle install

# Adiciona configurações do nginx
ADD docker/webapp.conf /etc/nginx/sites-enabled/webapp.conf

# Remove configuracao default do nginx
RUN rm /etc/nginx/sites-enabled/default

# Limpa cache e tmp, diminuindo tamanho da imagem e ajudando no cache
RUN rm -rf /tmp/* /var/tmp/* && apt-get clean

# Executa o Nginx e o Puma
CMD service nginx start && bundle exec puma -C config/puma.rb

FROM ruby:2.7.3

# Set correct environment variables.
ENV HOME /root

ARG RAILS_ENV
ARG RAILS_RELATIVE_URL_ROOT

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && apt-get update && apt-get install -y nginx nodejs libmagickwand-dev \
 default-mysql-client  imagemagick pandoc cron yarn


# Instala o phantom
RUN curl -L https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2 | tar xj && \
 cp phantomjs-2.1.1-linux-x86_64/bin/phantomjs /usr/bin/ && yarn install --check-files 

WORKDIR /usr/src/app/umm

# Copia o Gemfile antes de aplicação para permitir o cache do bundle install
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
CMD cron && service nginx start && bundle exec puma -C config/puma.rb
# CMD cron && service nginx start && bundle exec puma -t 5:5 -p 3000 -e homologacao -C config/puma.rb

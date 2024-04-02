FROM ruby:3.1.1

RUN mkdir -p /etc/apt/keyrings
RUN curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
RUN echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list
RUN apt-get update && apt-get install -y nodejs
RUN npm install --global yarn
RUN node -v
RUN apt-get update && apt-get install -y build-essential libpq-dev locales nodejs \
    postgresql-client postgresql-client-common

RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8

ARG SECRET_KEY_BASE

ENV LANG en_US.UTF-8
ENV RAILS_ENV=production
ENV RAILS_MASTER_KEY=$RAILS_MASTER_KEY

WORKDIR /app

ADD . ./

RUN bundle config build.nokogiri --use-system-libraries
RUN gem install bundler && \
    bundle config set force_ruby_platform true && \
    bundle install --jobs 20 --retry 5 --without development test

ADD package.json package.json
ADD yarn.lock yarn.lock

RUN yarn install --check-files
RUN RAILS_ENV=production bundle exec rails assets:precompile

EXPOSE 3000

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]

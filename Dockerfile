FROM ruby:2.7.3
RUN apt-get update -qq && apt-get install -y nodejs npm yarn
RUN npm install --global yarn

# Chrome gem
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
RUN apt-get -y update && apt-get install -y google-chrome-stable
RUN wget -O /tmp/chromedriver.zip http://chromedriver.storage.googleapis.com/`curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE_91`/chromedriver_linux64.zip
RUN unzip /tmp/chromedriver.zip chromedriver -d /usr/local/bin/

WORKDIR /url_shortener_app
COPY Gemfile /url_shortener_app/Gemfile
COPY Gemfile.lock /url_shortener_app/Gemfile.lock
RUN bundle install
COPY . /url_shortener_app

# Build assets
RUN RAILS_ENV=production bundle exec rails assets:clobber
RUN RAILS_ENV=production bundle exec rails webpacker:compile

# Setup databases
RUN RAILS_ENV=production bundle exec rails db:drop
RUN RAILS_ENV=production bundle exec rails db:setup
RUN RAILS_ENV=test bundle exec rails db:test:prepare

CMD rm -f ./tmp/pids/server.pid && bundle exec rails s -p 3000 -b 0.0.0.0

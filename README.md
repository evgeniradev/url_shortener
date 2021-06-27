# URLShortener

A Rails-based URL shortener application.

#### Ruby Version
2.7.3

#### Rails Version
6.1.3

## Required Non-Ruby Dependencies
* Node.js
* Yarn - Package Manager
* Google Chrome(required to run the feature specs)

## Manual Installation

Install bundler:
```
$ gem install bundler
```

Install the Ruby gem dependencies:
```
$ bundle install
```

Install the Node.js dependencies:
```
$ yarn install
```

Build the frontend assets:
```
$ RAILS_ENV=production bundle exec rails webpacker:compile
```

Setup the databases:
```
$ RAILS_ENV=production bundle exec rails db:setup
$ RAILS_ENV=test bundle exec rails db:test:prepare
```

Start the application in production mode:
```
$ RAILS_ENV=production bundle exec rails s
```

Finally, load [http://localhost:3000](http://localhost:3000) in your browser.

### Running the tests

```
$ ./specs.sh
```

## [Docker](https://docs.docker.com/) Installation
Please note, you will need to have Docker Compose installed.

Build the container:
```
$ docker-compose build
```

Start the container:
```
$ docker-compose up
```

Finally, load [http://localhost:3000](http://localhost:3000) in your browser.

### Running the tests

```
$ docker-compose run --rm url_shortener_app ./specs.sh
```

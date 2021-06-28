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

Install the bundler gem:
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

Setup the databases:
```
$ bundle exec rails db:setup
$ bundle exec rails db:test:prepare
```

Start the application in development mode:
```
$ bundle exec rails s
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

Start the application in development mode:
```
$ docker-compose up
```

Finally, load [http://localhost:3000](http://localhost:3000) in your browser.

### Running the tests

```
$ docker-compose run --rm url_shortener_app ./specs.sh
```

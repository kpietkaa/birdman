# README [![Build Status](https://travis-ci.com/kpietkaa/birdman.svg?token=P4viZXtTN8uiyzVDpVi6&branch=master)](https://travis-ci.com/kpietkaa/birdman)

Project name: **birdman**

It's my Web portal for veterinary services created for my bachelor degree.

* Ruby version: 2.3.0
* Rails version: 4.2.2
* Database: PostgreSQL

Set up PostgreSQL DB:

* Create a user in postgresql
```
$ createuser birdman
```

* Create development and test databases
```
$ createdb -Obirdman -Eunicode birdman_development
$ createdb -Obirdman -Eunicode birdman_test
```

To run the application, write in your terminal:
```
rails s
```
Your version of the app will appear on address: http://localhost:3000/

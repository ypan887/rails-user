## Intro

This repo if for pai-test. 

## To Start

1. git clone to local dir
2. run `bundle install` to install dependency
3. run `bundle exec rake db:migrate` to migrate db
4. run `bundle exec rake db:test:prepare` to prepare for test

## To Test

### Test all

run `bundle exec rspec spec` to run all test

### Test model

run `bundle exec rspec spec/models` to run all model test

Right now, it has unit test on User model.

### Test feature

run `bundle exec rspec spec/features` to run all feature test

Right now, it hsa acceptance test on user login, logout, and sign up feature.

### note

1. The repo is meant to be a minimum setup to test user sign in, sign up and sign out features
2. for convience, I add a migrate to create user table and some attributes needed for user authenticationand. I added a few named route so that path helper can be used in spec file.
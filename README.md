# [snap-cloud][hk-app]
A CS169 Project to create a new cloud sharing system for [Snap<i>!</i>][sbe].

* [![Code Climate](https://codeclimate.com/github/snap-cloud/snap-cloud/badges/gpa.svg)](https://codeclimate.com/github/snap-cloud/snap-cloud)

* [![Build Status](https://travis-ci.org/snap-cloud/snap-cloud.svg?branch=master)](https://travis-ci.org/snap-cloud/snap-cloud)

* [![Coverage Status](https://coveralls.io/builds/2178945/badge)](https://coveralls.io/builds/2178945)

* [![Inline docs](http://inch-ci.org/github/snap-cloud/snap-cloud.svg?branch=master)](http://inch-ci.org/github/snap-cloud/snap-cloud)

* 
For CS169: Please see the [wiki][wiki] for documentation about each iteration.

# What is Snap<i>!</i>?
This section is `TODO`
- Snap<i>!</i> GH Repo
- Snap<i>!</i> homepage
- scratch site

## Setting Up
This (currently) project uses Rails 4.2.1 and Ruby 2.2.1, and aims to be always
up to date!

The Heroku destination for the app is `https://ucbsnap.herokuapp.com`

1. **CLONE WITH `-r`** `git clone -r git@github.com:snap-cloud/snap-cloud.git`
1. You should have `rvm` or similar installed.
2. `bundle install --without production`
3. `git remote add heroku git@heroku.com:ucbsnap.git`

[hk-app]: https://ucbsnap.herokuapp.com
[sbe]: http://snap.berkeley.edu
[wiki]: https://github.com/snap-cloud/snap-cloud/wiki/Iteration-0-Deliverables

## Development Notes

* GitHub Flow [link needed...]

* The awesome print gem
```
$ rails console
> require 'awesome_print'
ap SomeObject
```
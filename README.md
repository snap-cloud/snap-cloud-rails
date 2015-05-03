# [snap-cloud][hk-app]
A CS169 Project to create a new cloud sharing system for [Snap<i>!</i>][sbe].

[![Code Climate](https://codeclimate.com/github/snap-cloud/snap-cloud/badges/gpa.svg)](https://codeclimate.com/github/snap-cloud/snap-cloud) [![Build Status](https://travis-ci.org/snap-cloud/snap-cloud.svg?branch=master)](https://travis-ci.org/snap-cloud/snap-cloud) [![Coverage Status](https://coveralls.io/repos/snap-cloud/snap-cloud/badge.svg?branch=master)](https://coveralls.io/r/snap-cloud/snap-cloud?branch=master) [![Test Coverage](https://codeclimate.com/github/snap-cloud/snap-cloud/badges/coverage.svg)](https://codeclimate.com/github/snap-cloud/snap-cloud) [![Inline docs](http://inch-ci.org/github/snap-cloud/snap-cloud.svg?branch=master)](http://inch-ci.org/github/snap-cloud/snap-cloud) [![Dependency Status](https://gemnasium.com/snap-cloud/snap-cloud.svg)](https://gemnasium.com/snap-cloud/snap-cloud)

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
1. `bin/setup`
2. `bundle install --without production`
3. `git remote add heroku git@heroku.com:ucbsnap.git`

### Dependencies
* nodeJS (>= v0.10) and npm
	* Used for `bower`
* Ruby 2.2.1
* imagemagick for testing profile and thumbnail management
* OS X -- if you have `brew` there will be an install script sometime...

## Development Notes
[ TODO: Move this section to a Wiki?]

* GitHub Flow [link needed...]

* The awesome print gem
```
$ rails console
ap SomeObject
```

## Heroku Deployment
Heroku Deployment uses a custom "build pack"
1. Install nodeJS
2. Post Node install, install bower
3. Then run the normal Ruby buildpack
4. Install with bundler
5. Serve using the Puma (multithreaded) webserver

[hk-app]: https://ucbsnap.herokuapp.com
[sbe]: http://snap.berkeley.edu
[wiki]: https://github.com/snap-cloud/snap-cloud/wiki/Iteration-0-Deliverables
# [![snap-logo](public/snap_logo_sm.png) Cloud][hk-app]
An interactive, project sharing site for [Snap<i>!</i>][sbe].

[![Code Climate](https://codeclimate.com/github/snap-cloud/snap-cloud/badges/gpa.svg)](https://codeclimate.com/github/snap-cloud/snap-cloud) [![Build Status](https://travis-ci.org/snap-cloud/snap-cloud.svg?branch=master)](https://travis-ci.org/snap-cloud/snap-cloud) [![Test Coverage](https://codeclimate.com/github/snap-cloud/snap-cloud/badges/coverage.svg)](https://codeclimate.com/github/snap-cloud/snap-cloud) [![Inline docs](http://inch-ci.org/github/snap-cloud/snap-cloud.svg?branch=master)](http://inch-ci.org/github/snap-cloud/snap-cloud) [![Dependency Status](https://gemnasium.com/snap-cloud/snap-cloud.svg)](https://gemnasium.com/snap-cloud/snap-cloud) [![security](https://hakiri.io/github/snap-cloud/snap-cloud/master.svg)](https://hakiri.io/github/snap-cloud/snap-cloud/master)

# What is Snap<i>!</i> Cloud?
This section is `TODO`
- Snap<i>!</i> GH Repo
- Snap<i>!</i> homepage
- scratch site

### Background
The initial design and development of this project was during Spring 2015 for Professor Fox's CS169, "Software Engineering" course at UC Berkeley. The original team members were:

* Alec Guertin
* Arjun Baokar
* Jason Wang
* Linda Lee
* Michael Ball
* Steven Campos

## Setting Up
This (currently) project uses Rails 4.2.1 and Ruby 2.2.1, and aims to be always
up to date!

The Heroku destination for the app is [`https://ucbsnap.herokuapp.com`][hk-app]

1. **CLONE WITH `-r`** `git clone -r git@github.com:snap-cloud/snap-cloud.git`
1. You should have `rvm` or similar installed.
1. `bin/setup`
2. `bundle install --without production`
3. `git remote add heroku git@heroku.com:ucbsnap.git`

### Dependencies
* nodeJS (>= v0.10) and npm
	* Used for `bower`
* Ruby 2.2.1
* `imagemagick` for testing profile and thumbnail management
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
To deploy to Heroku, you should simply need to do a `git push heroku master`. However, the build process is slightly more complex than a traditional Rails app.

Heroku Deployment uses a custom "build pack"
1. Install nodeJS
2. Post Node install, install bower
3. Then run the normal Ruby buildpack
4. Install with bundler
5. Serve using the Puma (multithreaded) web server

#### Pre-Reqs to Deployment:
1. Make sure you have a Postgres database added to the Heroku environment.
2. That's it?

## License
Please see the file `LICENESE` for a full copy of the current license for this project (AGPL 3).

[hk-app]: https://ucbsnap.herokuapp.com
[sbe]: http://snap.berkeley.edu
[wiki]: https://github.com/snap-cloud/snap-cloud/wiki/Iteration-0-Deliverables

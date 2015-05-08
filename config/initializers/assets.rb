# Be sure to restart your server when you modify this file.

Rails.application.configure do

  # Version of your assets, change this if you want to expire all your assets.
  config.assets.version = '1.0'

  # Add additional assets to the asset load path
  config.assets.paths << 'vendor/bower'

  # Precompile additional assets.
  # application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
  # FIXME: This line seems broken...
  config.assets.precompile += %w( stylesheets/** )

  # config.assets.precompile += [/.*\.js/,/.*\.css/]

  # This line isn't quite working for some reason...
  config.assets.precompile += ["*stylesheets*", "*javascripts*"]
  config.assets.precompile += ["splash.css", "about.css",
                            "profile.css", "project_listing.css"]

end

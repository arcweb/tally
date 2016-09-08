# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
Rails.application.config.assets.precompile += %w(common.css static.css users.css bootstrap-datepicker.css)

# Library and miscellaneous files
Rails.application.config.assets.precompile += [
  "lib/jquery-interdependencies.js",
  "lib/bootstrap-datepicker.js",
  "lib/moment.js",
  "users.js"
]

# Angular files
Rails.application.config.assets.precompile += [
  "angular/directives/editable-field.js",
  "angular/controllers/admin-notifications-controller.js",
  "angular/services/time-request-service.js",
  "angular/services/user-service.js",
  "angular/user-profile.js",
  "angular/admin-app.js"
]

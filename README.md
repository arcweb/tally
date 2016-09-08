# Tally: PTO Scheduling made easy(er)

## Features
- Request days off for Sick Days, PTO, and other reasons
- Admins can approve or reject requests
- See approved days and days that are still pending approval
- Uses Google OAuth for login

## Deployment
Deploying Tally is easy! Here's a button.

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

You'll need to add your own `google_client_id` and `google_client_secret` to the Heroku config variables. If you don't have those, follow [these instructions](https://developers.google.com/identity/sign-in/web/devconsole-project)

## Setup

To use Google Login locally, you'll need to add the `google_client_id` and `google_client_secret` to the `config/application.yml` file.

This repo includes a Vagrantfile for development using a Vagrant virtual environment. To get started with vagrant, run the following commands:
```
brew install vagrant
brew install chefdk
vagrant plugin install vagrant-omnibus
vagrant plugin install vagrant-berkshelf
vagrant up
vagrant ssh
```
Once your environment is set up, run:
```
bundle
rails s -b 0.0.0.0
```

Then visit localhost:3000 to see glorious Tally.

*Made with love by [Arcweb](http://arcweb.co)*
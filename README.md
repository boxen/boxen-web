# Boxen via the Web

## Development

We assume you already have Boxen working on your machine. You also need PostgreSQL installed.

    $ cd ~/src/boxen-web
    $ script/bootstrap
    $ script/tests
    $ bin/rake db:schema:load
    $ script/server
    $ open http://localhost:9393

## Deployment

The tl;dr version is you can run something like this:

Make a new GitHub OAuth Application. Then, run:

``` sh
heroku create my-new-boxen
heroku config:set \
  REPOSITORY="our-org/our-boxen" \
  GITHUB_CLIENT_ID="REDACTED" \
  GITHUB_CLIENT_SECRET="REDACTED" \
  GITHUB_ORG=my-github-org \
  GITHUB_TEAM_ID=99999999 \
  GITHUB_LOGIN=my-github-login \
  SECONDARY_MESSAGE="Do a thing before running the command below." \
  SECRET_TOKEN="your cookie signing token here" \
  USER_ORG="your org name" \
  GITHUB_ENTERPRISE_URL="https://github.<your_company>.com" \
  REF="master"
git push heroku master
heroku run bundle exec rake db:migrate
```

For details as to how and why, see the sections below.

### GitHub OAuth Application

Boxen Web utilizes GitHub OAuth to authenticate users because most Boxen
configurations for organizations will be private -- this requires an access
token to fetch the repository in the install script.

If your deployment lives at `https://example.herokuapp.com`,
you will need to create a GitHub OAuth application with the following config:

* Name - Boxen Web
* URL  - https://example.herokuapp.com
* Callback URL - https://example.herokuapp.com/auth/github/callback

### Heroku

You must use the Heroku Cedar stack (now the default with `heroku create`).

Additionally there are some required and optional environment variables that
should be set via `heroku config:set`:

* required
  * `REPOSITORY` to know which repo to download/setup
  * `GITHUB_CLIENT_ID` for OAuth.
  * `GITHUB_CLIENT_SECRET` for OAuth.
  * `SECRET_TOKEN` for cookie signing. Minimum length is 30 characters.
* optional
  * `GITHUB_ORG` to restrict access to members of an organization.
  * `GITHUB_TEAM_ID` to restrict access to members of a team.
  * `GITHUB_LOGIN` to restrict access to a single user by login name.
  * `SECONDARY_MESSAGE` to display an optional message on the main page.
  * `USER_ORG` to display an optional stamp with your username or organization.
  * `GITHUB_ENTERPRISE_URL` to use GHE for OAuth and `our-boxen` hosting.
  * `REF` to fetch a specific reference from REPOSITORY.

## Halp!

Use Issues or #boxen on irc.freenode.net.

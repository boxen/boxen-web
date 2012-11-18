# Boxen via the Web

## Development

We assume you already have Boxen working on your machine.

    $ cd ~/src/boxen-web
    $ script/bootstrap
    $ script/tests
    $ script/server
    $ open http://localhost:9393/

## Deployment

### GitHub OAuth Application

Boxen Web utilizes GitHub OAuth to authenticate users because most Boxen
configurations for organizations will be private -- this requires an access
token to fetch the repository in the install script.

If your deployment lives at `https://my-new-boxen.herokuapp.com/`,
you will need to create a GitHub OAuth application with the following config:

* Name - Boxen Web
* URL  - https://my-new-boxen.herokuapp.com/
* Callback URL - https://my-new-boxen.herokuapp.com/auth/github/callback

### Heroku

You must use the Heroku Cedar stack (now the default with `heroku create`).

Additionally there are some required and optional environment variables that
should be set via `heroku config:set`:

* required
  * `REPOSITORY` to know which repo to download/setup
  * `GITHUB_CLIENT_ID` for OAuth.
  * `GITHUB_CLIENT_SECRET` for OAuth.
* optional
  * `GITHUB_TEAM_ID` to restrict access to members of a team.
  * `SECONDARY_MESSAGE` to display an optional message on the main page.

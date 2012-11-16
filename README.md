# Boxen via the Web

## Development

We assume you already have Boxen working on your machine.

    $ cd ~/src/boxen-web
    $ script/bootstrap
    $ script/tests
    $ script/server
    $ open http://localhost:9393/

## Environment and Configuration

Here are the pertinent environment variables:

* `REPOSITORY` to know which repo to download/setup
* `GITHUB_CLIENT_ID` for OAuth.
* `GITHUB_CLIENT_SECRET` for OAuth.
* `GITHUB_TEAM_ID` (optional) to restrict access.
* `SECONDARY_MESSAGE` (optional) to display an optional message.
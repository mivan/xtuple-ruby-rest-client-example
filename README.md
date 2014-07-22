
## Sample Ruby client for xTuple REST API ##

### Prerequisites

- Ruby 2.0.0+ 

Since the request to get an access token will be made over SSL, you will need to make sure
that your environment has SSL [setup properly](https://github.com/lostisland/faraday/wiki/Setting-up-SSL-certificates).

### Setup Authentication

This client uses OAuth 2.0 with service accounts. Learn more about xTuple APIs and OAuth 2.0 here:
https://developers.google.com/accounts/docs/OAuth2

### Running the Sample

    $ bundle install
    $ bundle exec ruby analytics.rb


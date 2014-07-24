
## Sample Ruby client for xTuple REST API ##

### Prerequisites

- Ruby 2.0.0+

Since the request to get an access token will be made over SSL, you will need to make sure
that your environment has SSL [setup properly](https://github.com/lostisland/faraday/wiki/Setting-up-SSL-certificates).

### Setup Authentication

This client uses OAuth 2.0 with service accounts.

### Running the Example

    $ bundle install
    $ bundle exec ruby analytics.rb

## License

[Apache License, Version 2.0](http://www.apache.org/licenses/LICENSE-2.0.html)

Copyright (c) 2012-2013 xTuple [http://www.xtuple.com/](http://www.xtuple.com/)

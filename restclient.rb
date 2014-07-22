require 'google/api_client'
require 'signet/oauth_2/client'
require 'dotenv'
# This just downgrades the SSL error to a warning
# Not a great "fix"
require 'openssl'
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

Dotenv.load

database = ENV['DATABASE']
host = "https://" + ENV['HOST']

if ENV['PORT']
  host = host + ":" + ENV['PORT']
end
baseUrl = host + "/" + database

# Initialize the client.
client = Google::APIClient.new(
  :application_name => 'xtuple',
  :application_version => 'v1alpha1',
  :port => 8443,
  :host => ENV['HOST']
)

# Load your credentials for the service account
key = Google::APIClient::KeyUtils.load_from_pkcs12(ENV['PRIVATE_KEY_PATH'], ENV['PRIVATE_KEY_SECRET'])
client.authorization = Signet::OAuth2::Client.new(
  :authorization_uri => baseUrl + '/oauth/auth',
  :token_credential_uri => baseUrl + '/oauth/token',
  :audience => baseUrl + '/oauth/token',
  :scope => baseUrl + '/auth/' + database,
  :issuer => ENV['CLIENTID'],
  :signing_key => key,
  :person => ENV['USERNAME'])

  # Request a token for our service account
  client.authorization.fetch_access_token!

  # Register the discovery URL for xTuple REST
  client.register_discovery_uri('xtuple', 'v1alpha1', baseUrl + '/discovery/v1alpha1/apis/v1alpha1/rest')

  # Initialize xTuple REST API. Note this will make a request to the
  # discovery service every time.
  service = client.discovered_api('xtuple', 'v1alpha1')

  # Execute the query
  result = client.execute(
    :api_method => service[database].Contact.get,
    :parameters => {}
  )
  #
  puts result

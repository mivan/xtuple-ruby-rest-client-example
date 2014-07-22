require 'google/api_client'
require 'signet/oauth_2/client'
require 'dotenv'
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
  :application_name => ENV['APPLICATION_NAME'],
  :application_version => ENV['APPLICATION_VERSION'],
  :port => 8443,
  :host => ENV['HOST'],
  :discovery_path => baseUrl + '/discovery/v1alpha1/apis'
)

# Load your credentials for the service account
key = Google::APIClient::KeyUtils.load_from_pkcs12(ENV['PRIVATE_KEY_PATH'], ENV['PRIVATE_KEY_SECRET'])
client.authorization = Signet::OAuth2::Client.new(
  :token_credential_uri => baseUrl + '/oauth/token',
  :audience => baseUrl + '/oauth/token',
  :scope => baseUrl + '/auth/' + database,
  :issuer => ENV['CLIENTID'],
  :signing_key => key,
  :person => ENV['USERNAME'])

  puts client.authorization.person
  puts client.authorization.scope
  puts client.authorization.audience
  puts client.authorization.token_credential_uri
  puts client.authorization.issuer

  # Request a token for our service account
  client.authorization.fetch_access_token!

  # Initialize xTuple REST API. Note this will make a request to the
  # discovery service every time.

  service = client.discovered_api('')

  # Execute the query
  contacts = client.execute(
    :api_method => service[test].Contact.list(),
    :parameters => {})

  puts contacts

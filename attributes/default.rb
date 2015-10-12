# tweaks to existing repose attributes

default['wrapper-repose']['filters'] = %w(
  header-normalization,
  keystone-v2,
  extract-device-id,
  valkyrie-authorization,
  merge-header
)

# default['repose']['filters'] = %w(derp)

default['repose']['endpoints'] = [{
  cluster_id: 'repose',
  id: node[:name],
  protocol: 'http',
  hostname: node[:fqdn],
  port: '8090',
  root_path: '/',
  default: true
}]

default['repose']['header_normalization']['uri_regex'] = nil
default['repose']['header_normalization']['whitelist'] = []

default['repose']['header_normalization']['blacklist'] = [{
  id: 'authorization',
  http_methods: 'ALL',
  headers: %w(
    X-Authorization
    X-Token-Expires
    X-Identity-Status
    X-Impersonator-Id
    X-Impersonator-Name
    X-Impersonator-Roles
    X-Roles
    X-Contact-Id
    X-Device-Id
    X-User-Id
    X-User-Name
    X-PP-User
    X-PP-Groups
    X-Catalog
    X-Subject-Token
    X-Subject-Name
    X-Subject-ID
    X-Support-Token
  )
}]

# attributes for new recipes

default['wrapper-repose']['extract_device_id']['cluster_id'] = ['all']
default['wrapper-repose']['extract_device_id']['uri_regex'] = '.*/hybrid:\d+/entities/.*'
default['wrapper-repose']['extract_device_id']['maas_service_uri'] = 'http://localhost:7010'
default['wrapper-repose']['extract_device_id']['cache_timeout_millis'] = 60000
default['wrapper-repose']['extract_device_id']['delegating_quality'] = nil

default['wrapper-repose']['keystone_v2']['cluster_id'] = ['all']
default['wrapper-repose']['keystone_v2']['uri_regex'] = nil

# defaults are for dev/local (recipe overrides with encrypted data bag item by ele environment)
default['wrapper-repose']['keystone_v2']['identity_username'] = 'identity_username'
default['wrapper-repose']['keystone_v2']['identity_password'] = 'identity_p4ssw0rd'

# TODO: read this from somewhere else (already exists in chef?  surely...) and make dependent on environment
# 'https://staging.identity.api.rackspacecloud.com'
# 'https://identity.api.rackspacecloud.com'
default['wrapper-repose']['keystone_v2']['identity_uri'] = 'http://identity.api.example.com'
default['wrapper-repose']['keystone_v2']['identity_set_roles'] = true
default['wrapper-repose']['keystone_v2']['identity_set_groups'] = false
default['wrapper-repose']['keystone_v2']['identity_set_catalog'] = false
default['wrapper-repose']['keystone_v2']['whitelist_uri_regex'] = '.*/v1.0/(\d+|[a-zA-Z]+:\d+)/agent_installers/.+(\.sh)?'
default['wrapper-repose']['keystone_v2']['tenant_uri_extraction_regex'] = '.*/v1.0/(\d+|[a-zA-Z]+:\d+)/.+'
default['wrapper-repose']['keystone_v2']['preauthorized_service_admin_role'] = nil
default['wrapper-repose']['keystone_v2']['token_timeout_variability'] = 15
default['wrapper-repose']['keystone_v2']['token_timeout'] = 600

default['wrapper-repose']['valkyrie_authorization']['cluster_id'] = ['all']
default['wrapper-repose']['valkyrie_authorization']['uri_regex'] = '.*/hybrid:\d+/(?!agent_installers/).*'
default['wrapper-repose']['valkyrie_authorization']['cache_timeout_millis'] = 60000
default['wrapper-repose']['valkyrie_authorization']['enable_masking_403s'] = true
default['wrapper-repose']['valkyrie_authorization']['delegating_quality'] = nil

# TODO: make this dependent on environment
# 'https://valkyrie.staging.my.rackspace.com'
# 'https://valkyrie.my.rackspace.com'
default['wrapper-repose']['valkyrie_authorization']['valkyrie_server_uri'] = 'http://valkyrie.my.example.com'

# defaults are for dev/local (recipe overrides with encrypted data bag item by ele environment)
default['wrapper-repose']['valkyrie_authorization']['valkyrie_server_username'] = 'username'
default['wrapper-repose']['valkyrie_authorization']['valkyrie_server_password'] = 'p4ssw0rd'

default['wrapper-repose']['merge_header']['cluster_id'] = ['all']
default['wrapper-repose']['merge_header']['uri_regex'] = nil
default['wrapper-repose']['merge_header']['headers'] = %w(X-Roles X-Impersonator-Roles)

# TODO: check if this could conflict with another use of the java cookbook
# java configuration
default['java']['install_flavor'] = 'oracle'
default['java']['oracle']['accept_oracle_download_terms'] = true
default['java']['jdk_version'] = '8'
default['java']['set_default'] = false
default['java']['reset_alternatives'] = false
default['java']['use_alt_suffix'] = false

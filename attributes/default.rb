# tweaks to existing repose attributes

default['repose']['peers'] = [{
  cluster_id: 'repose',
  id: 'repose_node',
  hostname: 'localhost',
  port: '13579'
}]

default['repose']['filters'] = %w(
  header-normalization
  header-translation
  keystone-v2
  extract-device-id
  valkyrie-authorization
  merge-header
)

default['repose']['endpoints'] = [{
  cluster_id: 'repose',
  id: 'public_api',
  protocol: 'http',
  hostname: 'localhost',
  port: '32321',
  root_path: '/',
  default: true
}]

default['repose']['connection_timeout'] = 60000 # in millis
default['repose']['read_timeout'] = 60000 # in millis

default['repose']['connection_pool']['socket_timeout'] = 60000 # in millis
default['repose']['connection_pool']['connection_timeout'] = 60000 # in millis

default['repose']['header_normalization']['cluster_id'] = ['all']
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

default['repose']['version'] = '7.1.7.0'

default['repose']['owner'] = 'repose'
default['repose']['group'] = 'repose'

# attributes for new recipes
default['repose']['bundle_name'] = 'custom-bundle-1.0-SNAPSHOT.ear'

default['repose']['header_translation']['cluster_id'] = ['all']
default['repose']['header_translation']['uri_regex'] = nil

default['repose']['extract_device_id']['cluster_id'] = ['all']
default['repose']['extract_device_id']['uri_regex'] = '.*/hybrid:\d+/entities/.*'
default['repose']['extract_device_id']['maas_service_uri'] = 'http://localhost:32321'
default['repose']['extract_device_id']['cache_timeout_millis'] = 60000
default['repose']['extract_device_id']['delegating_quality'] = nil

default['repose']['keystone_v2']['cluster_id'] = ['all']
default['repose']['keystone_v2']['uri_regex'] = nil

# defaults are for dev/local (recipe overrides with encrypted data bag item by ele environment)
default['repose']['keystone_v2']['identity_username'] = 'identity_username'
default['repose']['keystone_v2']['identity_password'] = 'identity_p4ssw0rd'

default['repose']['keystone_v2']['identity_uri'] = 'http://localhost:8900/identity'
default['repose']['keystone_v2']['identity_set_roles'] = true
default['repose']['keystone_v2']['identity_set_groups'] = false
default['repose']['keystone_v2']['identity_set_catalog'] = false
default['repose']['keystone_v2']['whitelist_uri_regex'] = '.*/v1.0/(\d+|[a-zA-Z]+:\d+)/agent_installers/.+(\.sh)?'
default['repose']['keystone_v2']['tenant_uri_extraction_regex'] = '.*/v1.0/(\d+|[a-zA-Z]+:\d+)/.+'
default['repose']['keystone_v2']['preauthorized_service_admin_role'] = nil
default['repose']['keystone_v2']['token_timeout_variability'] = 15
default['repose']['keystone_v2']['token_timeout'] = 600

default['repose']['valkyrie_authorization']['cluster_id'] = ['all']
default['repose']['valkyrie_authorization']['uri_regex'] = '.*/hybrid:\d+/(?!agent_installers/).*'
default['repose']['valkyrie_authorization']['cache_timeout_millis'] = 60000
default['repose']['valkyrie_authorization']['enable_masking_403s'] = true
default['repose']['valkyrie_authorization']['delegating_quality'] = nil
default['repose']['valkyrie_authorization']['valkyrie_server_uri'] = 'http://localhost:8900/valkyrie/v2.0'
# defaults are for dev/local (recipe overrides with encrypted data bag item by ele environment)
default['repose']['valkyrie_authorization']['valkyrie_server_username'] = 'valkyrie_username'
default['repose']['valkyrie_authorization']['valkyrie_server_password'] = 'valkyrie_p4ssw0rd'

default['repose']['merge_header']['cluster_id'] = ['all']
default['repose']['merge_header']['uri_regex'] = nil
default['repose']['merge_header']['headers'] = %w(X-Roles X-Impersonator-Roles)

default['java']['install_flavor'] = 'oracle'
default['java']['oracle']['accept_oracle_download_terms'] = true
default['java']['jdk_version'] = '8' # override_default
default['java']['arch'] = 'x86_64' # ensure this is set (nil kernel[:machine] in some cases)
default['java']['jdk']['8']['x86_64']['url'] = 'http://f203e7ccada4106422d5-525efbc04163a45a7d6a38d479995b34.r68.cf2.rackcdn.com/jdk-8u60-linux-x64.tar.gz'
default['java']['set_default'] = false
default['java']['reset_alternatives'] = false
default['java']['use_alt_suffix'] = false

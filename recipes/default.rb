# do some pre-configuration to ensure repose starts with the correct java, etc. (pkg install will auto-start service)
cookbook_file '/etc/sysconfig/repose' do
  source 'sysconfig/repose'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

include_recipe 'java'

# TODO: download https://ele-buildbot.cm.k1k.me/distfiles/custom-bundle/custom-bundle-1.0-SNAPSHOT.ear and place in /usr/share/repose/filters/

# TODO: update from wiki instructions https://one.rackspace.com/pages/viewpage.action?title=Install+Repose+on+ELE+VM&spaceKey=monitoring

include_recipe 'repose'

if %w(ele-stage ele-prod).include?(node.chef_environment)
  # load non-default secrets
  repose_credentials = Chef::EncryptedDataBagItem.load('credentials', 'repose')

  identity_username = repose_credentials["identity_username_#{node.ele.env}"]
  identity_password = repose_credentials["identity_password_#{node.ele.env}"]

  valkyrie_username = repose_credentials["valkyrie_username_#{node.ele.env}"]
  valkyrie_password = repose_credentials["valkyrie_password_#{node.ele.env}"]

  node.set['repose']['keystone_v2']['identity_username'] = identity_username
  node.set['repose']['keystone_v2']['identity_password'] = identity_password

  node.set['repose']['valkyrie_authorization']['valkyrie_server_username'] = valkyrie_username
  node.set['repose']['valkyrie_authorization']['valkyrie_server_password'] = valkyrie_password

  # set non-default (environment-specific) configuration
  node.set['repose']['keystone_v2']['identity_uri'] = node['ele']['us_identity_service_url_2']
end

# override various upstream cookbook definitions

filter_cluster_map = {
  :'api-validator'          => node['repose']['api_validator']['cluster_id'],
  :'client-auth'            => node['repose']['client_auth']['cluster_id'],
  :'client-authorization'   => node['repose']['client_authorization']['cluster_id'],
  :'content-type-stripper'  => node['repose']['content_type_stripper']['cluster_id'],
  :derp                     => node['repose']['derp']['cluster_id'],
  :'header-identity'        => node['repose']['header_identity']['cluster_id'],
  :'header-normalization'   => node['repose']['header_normalization']['cluster_id'],
  :'header-translation'     => node['repose']['header_translation']['cluster_id'],
  :'ip-identity'            => node['repose']['ip_identity']['cluster_id'],
  :'rackspace-auth-user'    => node['repose']['rackspace_auth_user']['cluster_id'],
  :'rate-limiting'          => node['repose']['rate_limiting']['cluster_id'],
  :'slf4j-http-logging'     => node['repose']['slf4j_http_logging']['cluster_id'],
  :translation              => node['repose']['translation']['cluster_id'],
  :'uri-identity'           => node['repose']['uri_identity']['cluster_id'],
  :'keystone-v2'            => node['repose']['keystone_v2']['cluster_id'],
  :'extract-device-id'      => node['repose']['extract_device_id']['cluster_id'],
  :'valkyrie-authorization' => node['repose']['valkyrie_authorization']['cluster_id'],
  :'merge-header'           => node['repose']['merge_header']['cluster_id']
}

filter_uri_regex_map = {
  :'header-normalization'   => node['repose']['header_normalization']['uri_regex'],
  :'keystone-v2'            => node['repose']['keystone_v2']['uri_regex'],
  :'extract-device-id'      => node['repose']['extract_device_id']['uri_regex'],
  :'valkyrie-authorization' => node['repose']['valkyrie_authorization']['uri_regex'],
  :'merge-header'           => node['repose']['merge_header']['uri_regex']
}

service_cluster_map = {
  :'dist-datastore' => node['repose']['dist_datastore']['cluster_id']
}

begin
  r = resources(template: "#{node['repose']['config_directory']}/system-model.cfg.xml")
  r.cookbook 'repose-wrapper'
  r.source 'system-model.cfg.xml.erb'
  r.owner node['repose']['owner']
  r.group node['repose']['group']
  r.mode 0644
  r.variables(
    cluster_ids: node['repose']['cluster_ids'],
    rewrite_host_header: node['repose']['rewrite_host_header'],
    nodes: node['repose']['peers'],
    services: node['repose']['services'],
    service_cluster_map: service_cluster_map,
    filters: node['wrapper-repose']['filters'],
    filter_cluster_map: filter_cluster_map,
    filter_uri_regex_map: filter_uri_regex_map,
    endpoints: node['repose']['endpoints']
  )
  r.notifies :restart, 'service[repose-valve]'
rescue Chef::Exceptions::ResourceNotFound
  Chef::Log.warn("template #{node['repose']['config_directory']}/system-model.cfg.xml not defined upstream")
end

resources("template[#{node['repose']['config_directory']}/container.cfg.xml]").cookbook 'repose'

resources("template[#{node['repose']['config_directory']}/system-model.cfg.xml]").cookbook 'repose'

# TODO: make the version an attribute
remote_file '/usr/share/repose/filters/custom-bundle-1.0-SNAPSHOT.ear' do
  source 'https://ele-buildbot.cm.k1k.me/distfiles/custom-bundle/custom-bundle-1.0-SNAPSHOT.ear'
  owner 'repose'
  group 'repose'
  mode '0755'
  action :create
end

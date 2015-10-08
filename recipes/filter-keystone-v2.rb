include_recipe 'repose::install'

# unless node['repose']['filters'].include? 'keystone-v2'
#   filters = node['repose']['filters'] + ['keystone-v2']
#   node.normal['repose']['filters'] = filters
# end

template "#{node['repose']['config_directory']}/keystone-v2.cfg.xml" do
  owner node['repose']['owner']
  group node['repose']['group']
  mode '0644'
  variables(
    :identity_username => node['wrapper-repose']['keystone_v2']['identity_username'],
    :identity_password => node['wrapper-repose']['keystone_v2']['identity_password'],
    :identity_uri => node['wrapper-repose']['keystone_v2']['identity_uri'],
    :identity_set_roles => node['wrapper-repose']['keystone_v2']['identity_set_roles'],
    :identity_set_groups => node['wrapper-repose']['keystone_v2']['identity_set_groups'],
    :identity_set_catalog => node['wrapper-repose']['keystone_v2']['identity_set_catalog'],
    :whitelist_uri_regex => node['wrapper-repose']['keystone_v2']['whitelist_uri_regex'],
    :tenant_uri_extraction_regex => node['wrapper-repose']['keystone_v2']['tenant_uri_extraction_regex'],
    :preauthorized_service_admin_role => node['wrapper-repose']['keystone_v2']['preauthorized_service_admin_role'],
    :token_timeout_variability => node['wrapper-repose']['keystone_v2']['token_timeout_variability'],
    :token_timeout => node['wrapper-repose']['keystone_v2']['token_timeout']
  )
  notifies :restart, 'service[repose-valve]'
end

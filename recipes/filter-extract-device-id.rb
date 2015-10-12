include_recipe 'repose::install'

# add only if it doesn't already exist
node.set['repose']['filters'] |= %w(extract-device-id)

template "#{node['repose']['config_directory']}/extract-device-id.cfg.xml" do
  owner node['repose']['owner']
  group node['repose']['group']
  mode '0644'
  variables(
    maas_service_uri: node['repose']['extract_device_id']['maas_service_uri'],
    cache_timeout_millis: node['repose']['extract_device_id']['cache_timeout_millis'],
    delegating_quality: node['repose']['extract_device_id']['delegating_quality']
  )
  notifies :restart, 'service[repose-valve]'
end

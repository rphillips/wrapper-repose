include_recipe 'repose::install'

unless node['repose']['filters'].include? 'extract-device-id'
  filters = node['repose']['filters'] + ['extract-device-id']
  node.set['repose']['filters'] = filters
end

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

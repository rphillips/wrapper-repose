include_recipe 'repose::install'

# unless node['repose']['filters'].include? 'merge-header'
#   filters = node['repose']['filters'] + ['merge-header']
#   node.normal['repose']['filters'] = filters
# end

template "#{node['repose']['config_directory']}/merge-header.cfg.xml" do
  owner node['repose']['owner']
  group node['repose']['group']
  mode '0644'
  variables(
    headers: node['repose']['merge_header']['headers']
  )
  notifies :restart, 'service[repose-valve]'
end

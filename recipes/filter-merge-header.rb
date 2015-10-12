include_recipe 'repose::install'

# add only if it doesn't already exist
node.set['repose']['filters'] |= %w(merge-header)

template "#{node['repose']['config_directory']}/merge-header.cfg.xml" do
  owner node['repose']['owner']
  group node['repose']['group']
  mode '0644'
  variables(
    headers: node['repose']['merge_header']['headers']
  )
  notifies :restart, 'service[repose-valve]'
end

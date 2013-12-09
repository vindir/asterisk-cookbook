users = data_bag(:asterisk_users) || []
dialplan_contexts = data_bag(:asterisk_contexts) || []
config_dir = "#{node['asterisk']['prefix']['conf']}/asterisk"

directory config_dir

template "#{config_dir}/asterisk.conf" do
  source 'asterisk.conf.erb'
  mode 0644
  notifies :reload, resources('service[asterisk]')
end

%w{sip manager extensions}.each do |template_file|
  template "#{config_dir}/#{template_file}.conf" do
    source "#{template_file}.conf.erb"
    mode 0644
    variables :users => users, :dialplan_contexts => dialplan_contexts
    notifies :reload, resources('service[asterisk]')
  end
end

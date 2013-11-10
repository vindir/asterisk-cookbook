users = search(:asterisk_users) || []
auth = search(:auth, "id:google") || []
dialplan_contexts = search(:asterisk_contexts) || []

%w{sip manager modules extensions}.each do |template_file|
  template "/etc/asterisk/#{template_file}.conf" do
    source "#{template_file}.conf.erb"
    mode 0644
    variables :users => users, :auth => auth[0], :dialplan_contexts => dialplan_contexts
    notifies :reload, resources('service[asterisk]')
  end
end

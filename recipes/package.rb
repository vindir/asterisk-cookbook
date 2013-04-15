case node['platform']
when "ubuntu","debian"
  if node['asterisk']['use_digium_repo']
    apt_repository "asterisk" do
      uri "http://packages.asterisk.org/deb"
      components ["lucid", "main"]
      action :add
    end

    execute "update-asterisk-repo" do
      command "apt-get update"
    end
  end

  node['asterisk']['packages'].each do |pkg|
    package pkg do
      options "--force-yes"
    end
  end
end
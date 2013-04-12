unimrcp_name = "uni-ast-package-#{node['asterisk']['unimrcp']['version']}"
work_dir = "/tmp"
unimrcp_src_dir = "#{work_dir}/#{unimrcp_name}"

apr_src_dir = "#{unimrcp_src_dir}/libs/apr"
aprutil_src_dir = "#{unimrcp_src_dir}/libs/apr-util"
sofia_src_dir = "#{unimrcp_src_dir}/libs/sofia"

when "ubuntu","debian"
  node['asterisk']['unimrcp']['packages'].each do |pkg|
    package pkg do
      options "--force-yes"
    end
  end
end

remote_file "#{work_dir}/#{unimrcp_name}.tar.gz" do
  source "http://unimrcp.googlecode.com/files/#{unimrcp_name}.tar.gz"
  checksum ['asterisk']['unimrcp']['checksum']
  notifies :run, "bash[install_unimrcp]", :immediately
end

bash "install_unimrcp" do
  user "root"
  cwd work_dir
  code <<-EOH
    tar -zxf #{unimrcp_name}.tar.gz

    cd #{apr_src_dir}
    ./configure --prefix=#{node['asterisk']['unimrcp']['install_dir']}
    make
    make install

    cd #{aprutil_src_dir}
    ./configure --prefix=#{node['asterisk']['unimrcp']['install_dir']} --with-apr=#{apr_src_dir}
    make
    make install

    cd #{sofia_src_dir}
    ./configure --with-glib=no
    make
    make install

    cd #{unimrcp_src_dir}/unimrcp
    ./configure --prefix=#{node['asterisk']['unimrcp']['install_dir']} --with-apr=#{node['asterisk']['unimrcp']['install_dir']} --with-apr-util=#{node['asterisk']['unimrcp']['install_dir']}
    make
    make install

    cd cd #{unimrcp_src_dir}/modules
    ./configure
    make
    make install
  EOH
  action :nothing
end
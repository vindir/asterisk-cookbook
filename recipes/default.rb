#
# Cookbook Name:: asterisk
# Recipe:: default
#
# Copyright 2011, Chris Peplin
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

asterisk_user = node['asterisk']['user']
asterisk_group = node['asterisk']['group']

user node['asterisk']['user'] do
  system true
  home "#{node['asterisk']['prefix']['state']}/lib/asterisk"
  supports :manage_home => false    # Don't create the directory here
  not_if do
    begin
      Etc.getpwnam asterisk_user
    rescue
      nil
    end
  end
end

group node['asterisk']['group'] do
  system true
  not_if do
    begin
      Etc.getgrnam asterisk_group
    rescue
      nil
    end
  end
end

service "asterisk" do
  supports :restart => true, :reload => true, :status => :true, :debug => :true,
    "logger-reload" => true, "extensions-reload" => true,
    "restart-convenient" => true, "force-reload" => true
end

case node['asterisk']['install_method']
  when 'package'
    include_recipe 'asterisk::package'
  when 'source'
    include_recipe 'asterisk::source'
end

%w(lib/asterisk spool/asterisk run/asterisk log/asterisk).each do |subdir|
  path = "#{node['asterisk']['prefix']['state']}/#{subdir}"
  directory path do
    recursive true
  end

  # The chown is used to fix initial permissions after asterisk is installed
  # The conditional assumes permissions will remain correct afterwords
  execute "#{path} ownership" do
    command "chown -Rf #{asterisk_user}:#{asterisk_group} #{path}"
    not_if { Etc.getpwuid(File.stat(path).uid).name == asterisk_user and Etc.getgrgid(File.stat(path).gid).name == asterisk_group }
  end
end

include_recipe 'asterisk::config'

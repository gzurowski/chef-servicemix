#
# Cookbook Name:: servicemix
# Recipe:: default
#
# Copyright 2014, Gregor Zurowski
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

include_recipe 'java::default'

tmp = Chef::Config[:file_cache_path]
mirror = node['servicemix']['mirror']
version = node['servicemix']['version']
servicemix_home = "#{node['servicemix']['home']}/apache-servicemix-#{version}"

# Create OS user
user node['servicemix']['uid'] do
    comment "ServiceMix service user"
    action :create
    system true
    shell '/sbin/nologin'
    supports :manage_home => true
    home "/home/#{node['servicemix']['uid']}"
end

# create application directory and extract archive
unless File.exists?("#{servicemix_home}/bin/servicemix")
    directory servicemix_home do
        recursive true
    end

    directory servicemix_home do
        owner "#{node['servicemix']['uid']}"
        group "#{node['servicemix']['gid']}"
    end

    remote_file "#{tmp}/apache-servicemix-#{version}.zip" do
        source "#{mirror}/servicemix/apache-servicemix/#{version}/apache-servicemix-#{version}.zip"
        mode '0644'
    end

    execute "unzip #{tmp}/apache-servicemix-#{version}.zip" do
        cwd "#{node['servicemix']['home']}"
        user "#{node['servicemix']['uid']}"
        group "#{node['servicemix']['gid']}"
    end

    directory servicemix_home do
        owner "#{node['servicemix']['uid']}"
        group "#{node['servicemix']['gid']}"
        recursive true
    end
end

# configure init script
template "#{servicemix_home}/bin/servicemix.init" do
    source 'servicemix.init.erb'
    mode '0755'
    notifies :restart, 'service[servicemix]'
end

link '/etc/init.d/servicemix' do
    to "#{servicemix_home}/bin/servicemix.init"
end

service 'servicemix' do
  supports :restart => true
  action [:enable]
end

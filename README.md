Apache ServiceMix Chef Cookbook
===============================

This cookbook installs and configures Apache ServiceMix as a background service.

Usage
-----

Include the `servicemix` receipe in a run list (`receipe[servicemix]`) or cookbook (`include_receipe 'servicemix'`). 

Requirements
------------

This cookbook depends on the `java` cookbook.

### Platform

* CentOS, Redhat

Attributes
----------

* node['servicemix']['mirror'] - Download URL, default `https://repository.apache.org/content/repositories/releases/org/apache`.
* node['servicemix']['version'] - ServiceMix version to install, default `5.4.0`.
* node['servicemix']['home'] - Installation location, default `/opt`.
* node['servicemix']['uid'] - OS user ID that owns all files and runs the background service, default `smx`.
* node['servicemix']['gid'] = OS group ID that owns all files, default `smx`.
* node['servicemix']['install_java'] - Whether or not to install Java, default `true`

License and Author
------------------

* Author: Gregor Zurowski (<gregor@zurowski.org>)

Copyright 2014, Gregor Zurowski

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

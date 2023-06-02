# frozen_string_literal: true

#
# Copyright:: Copyright (c) 2019 Chef Software, Inc.
# Copyright:: Copyright (c) 2021 Firezone, Inc.
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
require 'json'

add_command_under_category 'version', 'general', 'Display current version of Firezone', 2 do
  version = JSON.parse(File.read('/opt/firezone/version-manifest.json'))['build_version']
  puts version
rescue Errno::ENOENT => e
  puts 'Error determining version!'
  puts e.message
  exit(1)
end

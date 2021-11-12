# Copyright (C) 2021 Nicolas Lamirault <nicolas.lamirault@gmail.com>

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

project_id = attribute('project_id', description:'GCP project id')
location = attribute("location", description:'GCP location')
topic_name = attribute("topic_name")

control 'pubsub-1' do
  impact 1.0

  title 'Ensure topic is correctly configure'

  tag platform: "GCP"
  tag category: 'Network'
  tag resource: "PubSub"
  tag effort: 0.2

  describe google_pubsub_topic(project: project_id, name: topic_name) do
    it { should exist }
    its('labels.keys') { should include 'env' }
    its('labels.keys') { should include 'service' }
    its('labels.keys') { should include 'made-by' }
  end

end

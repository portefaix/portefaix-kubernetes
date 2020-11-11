# Copyright (C) 2020 Nicolas Lamirault <nicolas.lamirault@gmail.com>

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
clustername = attribute("clustername", description:'The Kubernetes cluster name')

control 'project-1' do
  impact 1.0

  title 'Ensure GCP project connection'

  tag platform: 'GCP'
  tag category: 'Setup'
  tag resource: 'Project'
  tag effort: 0.2

  describe "#{project_id}/#{location}:" do
    subject { google_project(project: project_id, location: location, beta: true) }
    it { should exist }
    # its('logging_service') { should match /logging.googleapis.com\/kubernetes/ }
    # its('monitoring_service') { should match /monitoring.googleapis.com\/kubernetes/ }
  end

end

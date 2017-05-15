include_recipe 'aws'

app = search(:aws_opsworks_app).first
app.each do |sample|
  Chef::Log.info("********** app: '#{sample}' **********")
end

command = search(:aws_opsworks_command).first
command.each do |sample|
  Chef::Log.info("********** command: '#{sample}' **********")
end

node.each do |sample|
  Chef::Log.info("********** node: '#{sample}' **********")
end

execute 'kill old process' do
  command 'cd /srv/app && kill -9 `cat RUNNING_PID` && rm -f RUNNING_PID'
  only_if { File.exists?("/srv/app/RUNNING_PID") }
end

aws_s3_file "/var/chef/runs/#{command["id"]}/artifact" do
  bucket      "#{node["artifacts"][0]["location"]["s3Location"]["bucketName"]}"
  remote_path "#{node["artifacts"][0]["location"]["s3Location"]["objectKey"]}"
  region 'us-east-1'
end

execute 'unzip' do
  command "cd /var/chef/runs/#{command["id"]} && unzip -oq artifact && unzip play-sample-1.0-SNAPSHOT.zip"
end

link '/srv/app' do
  to "/var/chef/runs/#{command["id"]}/play-sample-1.0-SNAPSHOT"
end

execute 'start process' do
  command 'cd /srv/app && nohup 2>&1 ./bin/play-sample -Dplay.crypto.secret="asdfg" &'
end

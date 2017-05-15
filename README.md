Fork from https://github.com/awslabs/opsworks-linux-demo-cookbook-nodejs

# Build
* Run `berks package` to create a `cookbooks-*.tar.gz` file on your computer.
* Upload the generated `cookbooks-*.tar.gz` to an Amazon S3 bucket or a web server.
* On the AWS OpsWorks Stack settings toggle [Use custom Chef cookbooks](http://docs.aws.amazon.com/opsworks/latest/userguide/workingcookbook-installingcustom-enable.html) and set the Repository type and URL.
* On the OpsWorks Stack create a custom layer.
* Add `play_demo` as recipe in `setup` or add your own custom recpies.


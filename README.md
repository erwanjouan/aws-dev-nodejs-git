# aws-dev-nodejs-git

This is a fork from https://github.com/aws-samples/opsworks-windows-demo-nodejs 
to get a working project structure working with this cookbook
https://github.com/aws-samples/opsworks-linux-demo-cookbook-nodejs
in AWS Opsworks

### no load balancer

https://docs.aws.amazon.com/opsworks/latest/userguide/layers-elb.html

> AWS OpsWorks Stacks does not support Application Load Balancer. You can only use Classic Load Balancer with AWS OpsWorks Stacks.

### Notes

No build phase is required for NodeJS in OpsWorks (deployment package or what so ever).
Chef checkouts code from Github and installs all required dependencies during deployment. 
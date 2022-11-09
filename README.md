### Elasticsearch Assignment ###

## Prerequisites ##

[AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) - (Install AWS CLI & Configure aws profile)
    
[Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli#install-terraform) - (Install Terraform)

## Steps to provision infrastructure ##

    cd elastic-search/terraform
    terraform workspace new dev {create a new dev workspace}
    terraform init {terraform initialization - download required packages,setup backend config}
    terraform plan {check for infra changes}
    terraform apply {implement changes}

Q.1 What did you choose to automate the provisioning and bootstrapping of the instance? Why?

    Infra Automation: Terraform is used to provision the AWS resources.
    BootStraping: a bash script was created for installing & configuring the elasticsearch.

Q.2 How did you choose to secure ElasticSearch? Why?

    The elasticsearch instance is secured by ssl certificate along with basic authentication [username & password]. Apart from this security group is also in place.

Q.3 How would you monitor this instance? What metrics would you monitor?

    Currently we are making use of aws cloudwatch to monitor the ec2 instance. Important metrics would be CPU, Memory and Disk.   

Q.4 Could you extend your solution to launch a secure cluster of ElasticSearch nodes? What would need to change to support this use case?

    For lauching a secure cluster of elasticseach nodes the following changes would need to br implemented. 
    -- the cluster needs to created in a private subnet. 
    -- two seprate bash script would need to be created ie one for initial installation & configuration and the other one for adding nodes to existing cluster.
    -- lastly a vpn server needs to be setup to access the nodes of the elasticseach cluster.

Q.5 Could you extend your solution to replace a running ElasticSearch instance with little or no downtime? How?

    Yes it is possible to replace a running elasticsearch instance for that we would have to create a cluster of elasticsearch instances with replication enabled. 

Q.6 Was it a priority to make your code well structured, extensible, and reusable?

    Yes, it is was a priority to make the code well structured so that later the code can be modified easily.

Q.7 What sacrifices did you make due to time?

    Currently it's working with default self signed SSL certificate with IP. The SSL certificate provisioning {ACM} with DNS was skipped also the ec2 instance could be moved to a private subnet and accessed via a loadbalancer. 
    
    The s3 buckets use to store the state files & ssh keys are not part of current terraform scripts.

## Screenshots

##### Login with Basic Auth UserName & Password:

![image](https://github.com/sushilpandey-coditas/elastic-search/blob/main/infra-elasticsearch_screenshots/elasticsearch-basic-auth.png?raw=true)

##### Screen after login:

![image](https://github.com/sushilpandey-coditas/elastic-search/blob/main/infra-elasticsearch_screenshots/elasticsearch-working.png?raw=true)

##### elastic_search_password.txt

![image](https://github.com/sushilpandey-coditas/elastic-search/blob/main/infra-elasticsearch_screenshots/elasticsearch-password.png?raw=true)

##### s3 bucket contents

![image](https://github.com/sushilpandey-coditas/elastic-search/blob/main/infra-elasticsearch_screenshots/s3-bucket-ssh-key.png?raw=true)

#### terraform output

![image](https://github.com/sushilpandey-coditas/elastic-search/blob/main/infra-elasticsearch_screenshots/terraform-output.png?raw=true)

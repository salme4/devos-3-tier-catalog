region = "ap-northeast-2"

resource_prefix = "DevOS-3-tier-Demo"

vpc_cidr = "10.240.0.0/16"
subnet_cidr = "10.240.0.0/20"

bastion_instance_type = "t2.micro"
bastion_key_pair_name = "devos-demo-seoul-bastion-key"

web_instance_type = "t2.micro"
was_instance_type = "t2.micro"
instance_key_pair_name = "devos-demo-seoul-instance-key"

bucket_name = "devos-demo-tier-bucket"
bucket_versioning = true
bucket_private_acl = true

create_db = true
db_name = "demodb"
db_username = "demouser"
db_password = "demopass"

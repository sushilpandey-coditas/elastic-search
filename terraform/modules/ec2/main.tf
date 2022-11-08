resource "aws_instance" "elastic" {
  ami                         = var.ubuntu_ami
  instance_type               = var.instance_type
  key_name                    = module.key_pair.key_pair_name
  subnet_id                   = var.pub_sub1_id
  vpc_security_group_ids      = [var.sg_id]
  associate_public_ip_address = true
  iam_instance_profile = "${aws_iam_instance_profile.elasticsearchrole.name}"
  user_data                   = file(var.userdata)

  tags = {
    Name = "${var.environment}-elasticsearch"
  }
}

locals {
  key_name = "ssh-keys/${var.environment}-elstic-keypair.pem"
}

module "key_pair" {
  source = "terraform-aws-modules/key-pair/aws"

  key_name              = "${var.environment}-elastic-keypair"
  create_private_key    = true
  private_key_algorithm = "RSA"
  private_key_rsa_bits  = 4096
}

resource "aws_s3_object" "this" {
  key      = local.key_name
  bucket   = var.storage_bucket_name
  content  = module.key_pair.private_key_pem
  metadata = {}
}

resource "aws_iam_instance_profile" "elasticsearchrole" {
  name = "elasticsearchrole"
  role = "${aws_iam_role.elasticsearchrole.name}"
}

resource "aws_iam_role" "elasticsearchrole" {
  name = "es-s3-role"

  assume_role_policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "sts:AssumeRole",
            "Principal": {
                "Service": "ec2.amazonaws.com"
            }
        }
    ]
}
POLICY

}

resource "aws_iam_policy" "iam_policy" {
  name = "elasticsearch-iam-policy"

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "s3:*",
            "Effect": "Allow",
            "Resource": "*"
        }
    ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "ec2-s3-role" {
  role = "${aws_iam_role.elasticsearchrole.name}"
  policy_arn = "${aws_iam_policy.iam_policy.arn}"
}
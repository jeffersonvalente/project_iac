resource "aws_iam_instance_profile" "ip" {
        name = "aws_instance_profile_ec2"
        role =  aws_iam_role.ec2_instance_role.name
    }
data "aws_ami" "amazon_linux_2_ami" {
  most_recent = true
  name_regex  = "^amzn2-ami-hvm-[\\d.]+-x86_64-gp2$"
  owners      = ["amazon"]
}



resource "aws_instance" "web" {
  ami           = data.aws_ami.amazon_linux_2_ami.id
  instance_type = "t3.small"
  subnet_id = var.private_subnets_ids[0]

  tags = {
    Name = "HelloWorld"
  }
}
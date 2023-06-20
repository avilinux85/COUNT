variable "server_name" {
  type = list(string)
}

data "aws_ami" "amimumbai" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}


resource "aws_instance" "web" {
  ami           = data.aws_ami.amimumbai.id
  instance_type = "t2.micro"
  count         = length(var.server_name)
  tags = {
    Name = upper("${var.server_name[count.index]}")
  }
}

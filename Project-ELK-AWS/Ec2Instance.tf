# create Ec2 instance 
data "aws_availability_zones" "available" {}

resource "aws_instance" "ererkt_demo_elk" {
    ami = "ami-0b9064170e32bde34"
    instance_type = "m4.large"
    availability_zone = data.aws_availability_zones.availability.names[0]
    key_name = aws_key_pair.ererkt.key_name
    vpc_security_group_ids = [aws_security_group.allow_elk.id]
    depends_on = [aws_security_group.allow_elk]
    subnet_id = "subnet-e13d41ad"
    
    tags = {
        name = "ererkt_demo_elk_instance"
    }
    provisioner "file" {
        source = "kibana.yml"
        destination = "/tmp/kibana.yml"
    }
    provisioner "file" {
        source = "apache.conf"
        destination = "/tmp/apache.conf"
    }
    provisioner "file" {
        source = "installELK.sh"
        destination = "/tmp/installELK.sh"
    }
    provisioner "file" {
        source = "ererkt.com"
        destination = "/tmp/ererkt.com"
    }
    provisioner "remote-exec" {
        inline = [
            "chmod +x /tmp/installELK.sh",
            "sudo /tmp/installELK.sh"
        ]
    }
    connection {
        host = coalesce(self.public_ip, self.private_ip)
        type = "ssh"
        user = var.INSTANCE_USERNAME
        private_key = file(var.PATH_TO_PRIVATE_KEY)
    }
}   
    # assign IP to instance
    resource "aws_eip" "ip" {
        instance = aws_instance.ererkt_demo_elk.id
}
    output "public_ip" {
        value = aws_instance.ererkt_demo_elk.public_ip
 }
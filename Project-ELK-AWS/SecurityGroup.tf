resource "aws_security_group" "allow_elk" {
    name = "allow_elk"
    description = "allow all elasticsearch  traffic"
    #elkasticsearch port
    ingress {
        from_port = 9200
        to_port   = 9200
        protocol  = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    # kibana port 
    ingress {
        from_port = 5601
        to_port   = 5601
        protocol  = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    #logstash port
    ingress {
        from_port = 5043
        to_port   = 5044
        protocol  = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    # enable http 80 port
    ingress {
        from_port = 80
        to_port   = 80
        protocol  = "tcp"
        cidr_blocks = ["0.0.0.0/0"]       
    }
    ingress {
        from_port = 22
        to_port   = 22
        protocol  = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port   = 0
        protocol  = "-1"
        cidr_blocks = ["0.0.0.0/0"]       
    }
}



#-------------------VPC--------------
#-----VPC
resource "aws_vpc" "ss_vpc" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags {
    Name        = "${var.nt_projectname}-VPC"
    Owner       = "${var.company_name}"
    Environment = "${var.environment}"
   }
 }

#----Availability Zone
data "aws_availability_zones" "ss_available" {}

#----Internet Gateway
resource "aws_internet_gateway" "ss_internetgateway" {
  vpc_id = "${aws_vpc.ss_vpc.id}"

  tags {
    Name        = "${var.nt_projectname}-IGW"
    Owner       = "${var.company_name}"
    Environment = "${var.environment}"
   }
 }


#----NatGateway Elastic IP
resource "aws_eip" "ss_natgatewayeip" {
    vpc = "true"
 }

#----NatGateway
resource "aws_nat_gateway" "ss_natgateway" {
  subnet_id     = "${aws_subnet.ss_publicsubnet.*.id[count.index]}"
  depends_on    = ["aws_internet_gateway.ss_internetgateway"]
  allocation_id = "${aws_eip.ss_natgatewayeip.id}"

  tags {
    Name        = "${var.nt_projectname}-NatGateway"
    Owner       = "${var.company_name}"
    Environment = "${var.environment}"
   }  
 }

#----NatGateway Route
resource "aws_route" "private_natgateway" {
  route_table_id         = "${aws_route_table.ss_privatert.id}"
  nat_gateway_id         = "${aws_nat_gateway.ss_natgateway.id}"
  destination_cidr_block = "0.0.0.0/0"
  
  timeouts {
    create = "5m"
   }
 }

#----S3 VPC endpoint
resource "aws_vpc_endpoint" "ss_privates3endpoint" {
  vpc_id       = "${aws_vpc.ss_vpc.id}"
  service_name = "com.amazonaws.${var.aws_region}.s3"

  route_table_ids = ["${aws_vpc.ss_vpc.main_route_table_id}",
    "${aws_route_table.ss_publicrt.id}",
  ]

  policy = <<POLICY
{
    "Statement": [
        {
            "Action": "*",
            "Effect": "Allow",
            "Resource": "*",
            "Principal": "*"
        }
    ]
}
POLICY
}

#-----------ROUTE TABLES------
#----Public Route Table
resource "aws_route_table" "ss_publicrt" {
  vpc_id = "${aws_vpc.ss_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.ss_internetgateway.id}"
  }

  tags {  
    Name        = "${var.nt_projectname}-PublicRoute"
    Owner       = "${var.company_name}"
    Environment = "${var.environment}"
   }
 }

#-----Private Route Table
resource "aws_route_table" "ss_privatert" {
  vpc_id = "${aws_vpc.ss_vpc.id}"

  tags {
    Name        = "${var.nt_projectname}-PrivateRoute"
    Owner       = "${var.company_name}"
    Environment = "${var.environment}"
   }
 }

#-----Public Subnet/Route Table Association
resource "aws_route_table_association" "ss_publicassoc" {
  count          = "${aws_subnet.ss_publicsubnet.count}"
  subnet_id      = "${aws_subnet.ss_publicsubnet.*.id[count.index]}"
  route_table_id = "${aws_route_table.ss_publicrt.id}"
 }

#-----Private Subnet/Route Table Association
resource "aws_route_table_association" "ss_privateassoc" {
  count          = "${aws_subnet.ss_privatesubnet.count}"
  subnet_id      = "${aws_subnet.ss_privatesubnet.*.id[count.index]}"
  route_table_id = "${aws_route_table.ss_privatert.id}"
 }

#-----------SUBNETS------
#-----Public Subnets
resource "aws_subnet" "ss_publicsubnet" {
  count                   = 3
  vpc_id                  = "${aws_vpc.ss_vpc.id}"
  cidr_block              = "${var.public_cidrs[count.index]}"
  availability_zone       = "${data.aws_availability_zones.ss_available.names[count.index]}"
  map_public_ip_on_launch = true
 
  tags {
    Name        = "${var.nt_projectname}-PublicSubnet${count.index + 1}"
    Owner       = "${var.company_name}"
    Environment = "${var.environment}"
   }
 }

#-----Private Subnets
resource "aws_subnet" "ss_privatesubnet" {
  count                   = 3
  vpc_id                  = "${aws_vpc.ss_vpc.id}"
  cidr_block              = "${var.private_cidrs[count.index]}"
  availability_zone       = "${data.aws_availability_zones.ss_available.names[count.index]}"
  map_public_ip_on_launch = false
 
  tags {
    Name        = "${var.nt_projectname}-PrivateSubnet${count.index + 1}"
    Owner       = "${var.company_name}"
    Environment = "${var.environment}"
   }
 }

#-----Database Subnets
resource "aws_subnet" "ss_databasesubnet" {
  count                   = 3
  vpc_id                  = "${aws_vpc.ss_vpc.id}"
  cidr_block              = "${var.database_cidrs[count.index]}"
  availability_zone       = "${data.aws_availability_zones.ss_available.names[count.index]}"
  map_public_ip_on_launch = false 
 
  tags {  
    Name        = "${var.nt_projectname}-DatabaseSubnet${count.index + 1}"
    Owner       = "${var.company_name}"
    Environment = "${var.environment}"
   }
 }

#-----Database Subnet Group
resource "aws_db_subnet_group" "ss_dbsubnetgroup" {
  name       = "${var.nt_projectname}_dbsg"
  subnet_ids = ["${aws_subnet.ss_databasesubnet.*.id}"]

   tags {
    Name        = "${var.nt_projectname}_dbsg"
    Owner       = "${var.company_name}"
    Environment = "${var.environment}"
   }
 }

#-----------------SECURITY GROUPS------
#-----BastionHost Security Group
resource "aws_security_group" "ss_bastionhostsg" {
  name        = "${var.nt_projectname}-ss_bastionhostsg"
  vpc_id      = "${aws_vpc.ss_vpc.id}"
  description = "Used for access to the Bastion Host only"
  
 #SSH
  ingress {
    to_port     = 22 
    protocol    = "tcp"
    from_port   = 22
    cidr_blocks = ["${var.accessip}"]
   }

  egress {
    to_port     = 0
    protocol    = "-1"
    from_port   = 0   
    cidr_blocks = ["0.0.0.0/0"]
   }

  lifecycle {
    create_before_destroy = true
   }

   tags {  
    Name        = "${var.nt_projectname}-BastionHostSG"
    Owner       = "${var.company_name}"
    Environment = "${var.environment}"
   }
 }

#-----Public Subnets Security Group
resource "aws_security_group" "ss_publicsg" {
  name        = "${var.nt_projectname}-ss_publicsg"
  vpc_id      = "${aws_vpc.ss_vpc.id}"
  description = "Used for access to the Public Instances"
 
 #HTTP/GITLAB
  ingress {
    to_port     = 80
    protocol    = "tcp"
    from_port   = 80
    cidr_blocks = ["0.0.0.0/0"]
   }

 #HTTPS
  ingress {
    to_port     = 443
    protocol    = "tcp"
    from_port   = 443
    cidr_blocks = ["0.0.0.0/0"]
   }

 #JENKINS
  ingress {
    to_port     = 8080
    protocol    = "tcp"
    from_port   = 8080
    cidr_blocks = ["0.0.0.0/0"]
   }

 #ROCKETCHAT
  ingress {
    to_port     = 3000
    protocol    = "tcp"
    from_port   = 3000
    cidr_blocks = ["0.0.0.0/0"]
   }

  egress {
    to_port     = 0
    protocol    = "-1"
    from_port   = 0
    cidr_blocks = ["0.0.0.0/0"]
   }

  tags {  
    Name        = "${var.nt_projectname}-PublicSubnetSG"
    Owner       = "${var.company_name}"
    Environment = "${var.environment}"
   }
 }

#-----Private Subnets Security Group
resource "aws_security_group" "ss_privatesg" {
  name        = "${var.nt_projectname}-ss_privatesg"
  vpc_id      = "${aws_vpc.ss_vpc.id}"
  description = "Used for access to the private/application instances"
  
  ingress {
    to_port     = 0
    protocol    = "-1"
    from_port   = 0
    cidr_blocks = ["${var.vpc_cidr}"]
   }

  egress {
    to_port     = 0
    protocol    = "-1"
    from_port   = 0
    cidr_blocks = ["0.0.0.0/0"]
    }

   tags {  
    Name        = "${var.nt_projectname}-PrivateSubnetSG"
    Owner       = "${var.company_name}"
    Environment = "${var.environment}"
   }
 }

#-----Database Subnets Security Group
resource "aws_security_group" "ss_databasesg" {
  name        = "${var.nt_projectname}-ss_databasesg"
  vpc_id      = "${aws_vpc.ss_vpc.id}"
  description = "Used for access to the Database instances"
 
 #MySQL
  ingress { 
    to_port         = 3306
    from_port       = 3306
    protocol        = "tcp"
    security_groups = ["${aws_security_group.ss_publicsg.id}", 
           "${aws_security_group.ss_privatesg.id}", 
           "${aws_security_group.ss_bastionhostsg.id}"
        ]
    }

   tags {  
    Name        = "${var.nt_projectname}-DatabaseSubnetSG"
    Owner       = "${var.company_name}"
    Environment = "${var.environment}"
   }
 }



#-----------------ELASTIC LOAD BALANCER-----
#-----Application ELB
resource "aws_elb" "ss_applicationelb" {
  name            = "${var.nt_projectname}-AppELB"
  subnets         = ["${aws_subnet.ss_publicsubnet.*.id}"] 
  security_groups = ["${aws_security_group.ss_publicsg.id}"]

  listener {
    lb_port           = 80 
    lb_protocol       = "http"
    instance_port     = 80
    instance_protocol = "http"  
   }

  health_check { 
    target              = "TCP:80"
    timeout             = "${var.elb_timeout}"
    interval            = "${var.elb_interval}"
    healthy_threshold   = "${var.elb_healthythreshold}"
    unhealthy_threshold = "${var.elb_unhealthythreshold}"
   }

  idle_timeout                = 400
  connection_draining         = true 
  cross_zone_load_balancing   = true
  connection_draining_timeout = 400
  
  tags {  
    Name        = "${var.nt_projectname}-AppELB"
    Owner       = "${var.company_name}"
    Environment = "${var.environment}"
   }
 }


#-----DevOps ALB
resource "aws_lb" "ss_devopsalb" {
   name                       = "${var.nt_projectname}-DevOpsALB"
   subnets                    = ["${aws_subnet.ss_publicsubnet.*.id}"]
   internal                   = false 
   security_groups            = ["${aws_security_group.ss_publicsg.id}"]
   load_balancer_type         = "application"
   enable_deletion_protection = false
      
  tags {  
    Name        = "${var.nt_projectname}-DevOpsALB"
    Owner       = "${var.company_name}"
    Environment = "${var.environment}"
   }
 }


#-----Jenkins Target Group
resource "aws_lb_target_group" "ss_jenkinstg" {
   name     = "Jenkins-TG"
   port     = 8080
   vpc_id   = "${aws_vpc.ss_vpc.id}"
   protocol = "HTTP"
}

#-----Rocketchat Target Group
resource "aws_lb_target_group" "ss_rocketchattg" {
   name     = "RocketChat-TG"
   port     = 3000
   vpc_id   = "${aws_vpc.ss_vpc.id}"
   protocol = "HTTP"
}

#-----Gitlab Target Group
resource "aws_lb_target_group" "ss_gitlabtg" {
   name     = "GitLab-TG"
   port     = 80
   vpc_id   = "${aws_vpc.ss_vpc.id}"
   protocol = "HTTP"
}

#-----Jenkins Target Group Attachment
resource "aws_lb_target_group_attachment" "ss_jenkinstga" {
   port             = 8080
   target_id        = "${var.jenkins_instance}"
   target_group_arn = "${aws_lb_target_group.ss_jenkinstg.arn}"
 }

#-----Rocketchat Target Group Attachment
resource "aws_lb_target_group_attachment" "ss_rocketchattga" {
   port             = 3000
   target_id        = "${var.rocketchat_instance}"
   target_group_arn = "${aws_lb_target_group.ss_rocketchattg.arn}"
 }

#-----Gitlab Target Group Attachment
resource "aws_lb_target_group_attachment" "ss_gitlabtga" {
   port             = 80
   target_id        = "${var.gitlab_instance}"
   target_group_arn = "${aws_lb_target_group.ss_gitlabtg.arn}"
 }


#-----Jenkins ALB Listener
resource "aws_lb_listener" "ss_jenkinsln" {
   port              = 8080
   protocol          = "HTTP"
   load_balancer_arn = "${aws_lb.ss_devopsalb.arn}"

   default_action {
     type              = "forward"
     target_group_arn  = "${aws_lb_target_group.ss_jenkinstg.arn}"
   }
 }

#-----Rocketchat ALB Listener
resource "aws_lb_listener" "ss_rocketchatln" {
   port              = 3000
   protocol          = "HTTP"
   load_balancer_arn = "${aws_lb.ss_devopsalb.arn}"

   default_action {
     type              = "forward"
     target_group_arn  = "${aws_lb_target_group.ss_rocketchattg.arn}"
   }
 }

#-----Gitlab ALB Listener
resource "aws_lb_listener" "ss_gitlabln" {
   port              = 80
   protocol          = "HTTP"
   load_balancer_arn = "${aws_lb.ss_devopsalb.arn}"

   default_action {
     type              = "forward"
     target_group_arn  = "${aws_lb_target_group.ss_gitlabtg.arn}"
   }
 }

#-----------------ROUTE 53-----
/*
#----Delegation Set
resource "aws_route53_delegation_set" "ss_dns" {
  reference_name = "${var.nt_projectname}"
}
*/

#----Primary Zone
resource "aws_route53_zone" "ss_primaryzone" {
  name              = "${var.domain_name}.com"
 #delegation_set_id = "${aws_route53_delegation_set.ss_dns.id}"
  delegation_set_id = "N35M7HUCLORURJ"
 
}

#----Secondary Zone
resource "aws_route53_zone" "ss_secondaryzone" {
  name    = "${var.domain_name}.com"
  vpc {
   vpc_id = "${aws_vpc.ss_vpc.id}"
   }
 }

#----BastionHost Route53 Record
resource "aws_route53_record" "ss_bastionhost" {
  ttl     = "300"
  name    = "bastion.${var.domain_name}.com"
  type    = "A"
  zone_id = "${aws_route53_zone.ss_primaryzone.zone_id}"
  records = ["${var.bastionhost_eipaddress}"]
 }


#----Application Route53 Record
resource "aws_route53_record" "ss_application" {
  name    = "www.${var.domain_name}.com"
  type    = "A"
  zone_id = "${aws_route53_zone.ss_primaryzone.zone_id}"
  
  alias {
    name                   = "${aws_elb.ss_applicationelb.dns_name}"
    zone_id                = "${aws_elb.ss_applicationelb.zone_id}"
    evaluate_target_health = false
   }
 }


#----Jenkins Route53 Record
resource "aws_route53_record" "ss_jenkins" {
  ttl     = "300"
  name    = "jenkins.${var.domain_name}.com"
  type    = "CNAME"
  zone_id = "${aws_route53_zone.ss_primaryzone.zone_id}"
  records = ["${aws_lb.ss_devopsalb.dns_name}"]
 }

#----Rocketchat Route53 Record
resource "aws_route53_record" "ss_rocketchat" {
  ttl     = "300"
  name    = "rocketchat.${var.domain_name}.com"
  type    = "CNAME"
  zone_id = "${aws_route53_zone.ss_primaryzone.zone_id}"
  records = ["${aws_lb.ss_devopsalb.dns_name}"]
 }

#----Gitlab Route53 Record
resource "aws_route53_record" "ss_gitlab" {
  ttl     = "300"
  name    = "gitlab.${var.domain_name}.com"
  type    = "CNAME"
  zone_id = "${aws_route53_zone.ss_primaryzone.zone_id}"
  records = ["${aws_lb.ss_devopsalb.dns_name}"]
 }

#----Database Route53 Record
resource "aws_route53_record" "ss_database" {
  ttl     = "300"
  name    = "db.${var.domain_name}.com"
  type    = "CNAME"
  zone_id = "${aws_route53_zone.ss_secondaryzone.zone_id}"
  records = ["${var.database_instance}"]
 }

#-----SSH KeyPair
resource "aws_key_pair" "ss_auth" {
  key_name   = "${var.ss_keyname}"
  public_key = "${file(var.public_keypath)}" 
}


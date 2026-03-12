locals {
  public_v4_cidrs = [
    "10.10.10.0/24",
    "10.10.11.0/24",
  ]

  private_v4_cidrs = [
    "10.10.20.0/24",
    "10.10.30.0/24",
  ]

  internal_v4_cidrs = [
    "10.10.10.0/24",
    "10.10.11.0/24",
    "10.10.20.0/24",
    "10.10.30.0/24",
  ]

  bastion_internal_cidr = "10.10.10.0/24"
  zabbix_server_v4_cidr = "10.10.10.30/32"
}

resource "yandex_vpc_security_group" "bastion" {
  name        = "${local.project_name}-sg-bastion"
  description = "Security group for bastion host"
  network_id  = yandex_vpc_network.main.id

  ingress {
    description    = "SSH from admin IPv4 range"
    protocol       = "TCP"
    port           = 22
    v4_cidr_blocks = [var.admin_ipv4_cidr]
  }

  ingress {
    description    = "Zabbix passive checks from Zabbix server"
    protocol       = "TCP"
    port           = 10050
    v4_cidr_blocks = [local.zabbix_server_v4_cidr]
  }

  egress {
    description    = "Allow all outgoing traffic"
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_vpc_security_group" "alb" {
  name        = "${local.project_name}-sg-alb"
  description = "Security group for Application Load Balancer"
  network_id  = yandex_vpc_network.main.id

  ingress {
    description    = "HTTP from the Internet"
    protocol       = "TCP"
    port           = 80
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description       = "ALB health checks"
    protocol          = "TCP"
    port              = 30080
    predefined_target = "loadbalancer_healthchecks"
  }

  egress {
    description    = "HTTP to private web subnets"
    protocol       = "TCP"
    port           = 80
    v4_cidr_blocks = local.private_v4_cidrs
  }
}

resource "yandex_vpc_security_group" "web" {
  name        = "${local.project_name}-sg-web"
  description = "Security group for web servers"
  network_id  = yandex_vpc_network.main.id

  ingress {
    description    = "SSH from bastion internal subnet"
    protocol       = "TCP"
    port           = 22
    v4_cidr_blocks = [local.bastion_internal_cidr]
  }

  ingress {
    description    = "HTTP from ALB subnets"
    protocol       = "TCP"
    port           = 80
    v4_cidr_blocks = local.public_v4_cidrs
  }

  ingress {
    description       = "Load balancer health checks"
    protocol          = "TCP"
    port              = 80
    predefined_target = "loadbalancer_healthchecks"
  }

  ingress {
    description    = "Zabbix passive checks from Zabbix server"
    protocol       = "TCP"
    port           = 10050
    v4_cidr_blocks = [local.zabbix_server_v4_cidr]
  }

  egress {
    description    = "Allow all outgoing traffic"
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_vpc_security_group" "zabbix" {
  name        = "${local.project_name}-sg-zabbix"
  description = "Security group for Zabbix server"
  network_id  = yandex_vpc_network.main.id

  ingress {
    description    = "SSH from bastion internal subnet"
    protocol       = "TCP"
    port           = 22
    v4_cidr_blocks = [local.bastion_internal_cidr]
  }

  ingress {
    description    = "Zabbix web UI from admin IPv4 range"
    protocol       = "TCP"
    port           = 80
    v4_cidr_blocks = [var.admin_ipv4_cidr]
  }

  ingress {
    description    = "Zabbix agent active checks from internal subnets"
    protocol       = "TCP"
    port           = 10051
    v4_cidr_blocks = local.internal_v4_cidrs
  }

  egress {
    description    = "Allow all outgoing traffic"
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_vpc_security_group" "elastic" {
  name        = "${local.project_name}-sg-elastic"
  description = "Security group for Elasticsearch"
  network_id  = yandex_vpc_network.main.id

  ingress {
    description    = "SSH from bastion internal subnet"
    protocol       = "TCP"
    port           = 22
    v4_cidr_blocks = [local.bastion_internal_cidr]
  }

  ingress {
    description    = "Elasticsearch API from internal subnets"
    protocol       = "TCP"
    port           = 9200
    v4_cidr_blocks = local.internal_v4_cidrs
  }

  ingress {
    description    = "Zabbix passive checks from Zabbix server"
    protocol       = "TCP"
    port           = 10050
    v4_cidr_blocks = [local.zabbix_server_v4_cidr]
  }

  egress {
    description    = "Allow all outgoing traffic"
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_vpc_security_group" "kibana" {
  name        = "${local.project_name}-sg-kibana"
  description = "Security group for Kibana"
  network_id  = yandex_vpc_network.main.id

  ingress {
    description    = "SSH from bastion internal subnet"
    protocol       = "TCP"
    port           = 22
    v4_cidr_blocks = [local.bastion_internal_cidr]
  }

  ingress {
    description    = "Kibana web UI from admin IPv4 range"
    protocol       = "TCP"
    port           = 5601
    v4_cidr_blocks = [var.admin_ipv4_cidr]
  }

  ingress {
    description    = "Zabbix passive checks from Zabbix server"
    protocol       = "TCP"
    port           = 10050
    v4_cidr_blocks = [local.zabbix_server_v4_cidr]
  }

  egress {
    description    = "Allow all outgoing traffic"
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}
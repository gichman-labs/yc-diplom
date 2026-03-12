output "network_id" {
  description = "VPC network ID"
  value       = yandex_vpc_network.main.id
}

output "public_subnet_a_id" {
  description = "Public subnet A ID"
  value       = yandex_vpc_subnet.public_a.id
}

output "public_subnet_b_id" {
  description = "Public subnet B ID"
  value       = yandex_vpc_subnet.public_b.id
}

output "private_subnet_a_id" {
  description = "Private subnet A ID"
  value       = yandex_vpc_subnet.private_a.id
}

output "private_subnet_b_id" {
  description = "Private subnet B ID"
  value       = yandex_vpc_subnet.private_b.id
}

output "nat_gateway_id" {
  description = "NAT gateway ID"
  value       = yandex_vpc_gateway.nat.id
}

output "private_route_table_id" {
  description = "Private route table ID"
  value       = yandex_vpc_route_table.private.id
}

output "sg_bastion_id" {
  description = "Security group ID for bastion"
  value       = yandex_vpc_security_group.bastion.id
}

output "sg_alb_id" {
  description = "Security group ID for ALB"
  value       = yandex_vpc_security_group.alb.id
}

output "sg_web_id" {
  description = "Security group ID for web servers"
  value       = yandex_vpc_security_group.web.id
}

output "sg_zabbix_id" {
  description = "Security group ID for Zabbix"
  value       = yandex_vpc_security_group.zabbix.id
}

output "sg_elastic_id" {
  description = "Security group ID for Elasticsearch"
  value       = yandex_vpc_security_group.elastic.id
}

output "sg_kibana_id" {
  description = "Security group ID for Kibana"
  value       = yandex_vpc_security_group.kibana.id
}

output "vm_ssh_user" {
  description = "SSH user for instances"
  value       = var.ssh_user
}

output "bastion_public_ip" {
  description = "Public IP of bastion host"
  value       = yandex_compute_instance.bastion.network_interface[0].nat_ip_address
}

output "zabbix_public_ip" {
  description = "Public IP of Zabbix server"
  value       = yandex_compute_instance.zabbix.network_interface[0].nat_ip_address
}

output "kibana_public_ip" {
  description = "Public IP of Kibana server"
  value       = yandex_compute_instance.kibana.network_interface[0].nat_ip_address
}

output "bastion_private_ip" {
  description = "Private IP of bastion host"
  value       = yandex_compute_instance.bastion.network_interface[0].ip_address
}

output "web_a_private_ip" {
  description = "Private IP of web-a"
  value       = yandex_compute_instance.web_a.network_interface[0].ip_address
}

output "web_b_private_ip" {
  description = "Private IP of web-b"
  value       = yandex_compute_instance.web_b.network_interface[0].ip_address
}

output "zabbix_private_ip" {
  description = "Private IP of zabbix"
  value       = yandex_compute_instance.zabbix.network_interface[0].ip_address
}

output "elastic_private_ip" {
  description = "Private IP of elastic"
  value       = yandex_compute_instance.elastic.network_interface[0].ip_address
}

output "kibana_private_ip" {
  description = "Private IP of kibana"
  value       = yandex_compute_instance.kibana.network_interface[0].ip_address
}

output "bastion_fqdn" {
  description = "FQDN of bastion"
  value       = yandex_compute_instance.bastion.fqdn
}

output "web_a_fqdn" {
  description = "FQDN of web-a"
  value       = yandex_compute_instance.web_a.fqdn
}

output "web_b_fqdn" {
  description = "FQDN of web-b"
  value       = yandex_compute_instance.web_b.fqdn
}

output "zabbix_fqdn" {
  description = "FQDN of zabbix"
  value       = yandex_compute_instance.zabbix.fqdn
}

output "elastic_fqdn" {
  description = "FQDN of elastic"
  value       = yandex_compute_instance.elastic.fqdn
}

output "kibana_fqdn" {
  description = "FQDN of kibana"
  value       = yandex_compute_instance.kibana.fqdn
}

output "web_target_group_id" {
  description = "Target group ID for web backends"
  value       = yandex_alb_target_group.web.id
}

output "web_backend_group_id" {
  description = "Backend group ID for web backends"
  value       = yandex_alb_backend_group.web.id
}

output "web_http_router_id" {
  description = "HTTP router ID for web traffic"
  value       = yandex_alb_http_router.web.id
}

output "web_alb_id" {
  description = "ALB ID"
  value       = yandex_alb_load_balancer.web.id
}

output "web_alb_ipv4_address" {
  description = "Public IPv4 address of ALB"
  value       = yandex_alb_load_balancer.web.listener[0].endpoint[0].address[0].external_ipv4_address[0].address
}
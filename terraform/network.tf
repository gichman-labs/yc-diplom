locals {
  project_name = "yc-diplom"
}

resource "yandex_vpc_network" "main" {
  name = "${local.project_name}-network"
}

resource "yandex_vpc_gateway" "nat" {
  name = "${local.project_name}-nat-gateway"

  shared_egress_gateway {}
}

resource "yandex_vpc_route_table" "private" {
  name       = "${local.project_name}-private-rt"
  network_id = yandex_vpc_network.main.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    gateway_id         = yandex_vpc_gateway.nat.id
  }
}

resource "yandex_vpc_subnet" "public_a" {
  name           = "${local.project_name}-public-a"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.main.id
  v4_cidr_blocks = ["10.10.10.0/24"]
}

resource "yandex_vpc_subnet" "public_b" {
  name           = "${local.project_name}-public-b"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.main.id
  v4_cidr_blocks = ["10.10.11.0/24"]
}

resource "yandex_vpc_subnet" "private_a" {
  name           = "${local.project_name}-private-a"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.main.id
  v4_cidr_blocks = ["10.10.20.0/24"]
  route_table_id = yandex_vpc_route_table.private.id
}

resource "yandex_vpc_subnet" "private_b" {
  name           = "${local.project_name}-private-b"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.main.id
  v4_cidr_blocks = ["10.10.30.0/24"]
  route_table_id = yandex_vpc_route_table.private.id
}
\# Архитектурный план дипломного проекта Yandex Cloud



\## 1. Цель проекта



Развернуть отказоустойчивую инфраструктуру сайта в Yandex Cloud с использованием Terraform и Ansible.



\## 2. Обязательные компоненты



\* 2 web-сервера nginx в разных зонах

\* bastion host

\* Application Load Balancer

\* Zabbix

\* Elasticsearch

\* Kibana

\* Filebeat на web-серверах

\* NAT Gateway для приватного контура

\* Snapshot schedule для всех дисков



\## 3. Принятые имена ВМ



\* bastion

\* web-a

\* web-b

\* zabbix

\* elastic

\* kibana



\## 4. Ожидаемые внутренние FQDN



\* bastion.ru-central1.internal

\* web-a.ru-central1.internal

\* web-b.ru-central1.internal

\* zabbix.ru-central1.internal

\* elastic.ru-central1.internal

\* kibana.ru-central1.internal



\## 5. Размещение по зонам



\* bastion: ru-central1-a

\* web-a: ru-central1-a

\* web-b: ru-central1-b

\* zabbix: ru-central1-a

\* elastic: ru-central1-a

\* kibana: ru-central1-b



\## 6. Подсети



\* public-a: 10.10.10.0/24

\* public-b: 10.10.11.0/24

\* private-a: 10.10.20.0/24

\* private-b: 10.10.30.0/24



\## 7. Размещение ресурсов по подсетям



\* bastion -> public-a

\* zabbix -> public-a

\* kibana -> public-b

\* ALB -> public-a + public-b

\* web-a -> private-a

\* web-b -> private-b

\* elastic -> private-a



\## 8. Публичные IP



\* bastion -> да

\* zabbix -> да

\* kibana -> да

\* web-a -> нет

\* web-b -> нет

\* elastic -> нет



\## 9. Доступ



\* SSH к приватным ВМ только через bastion

\* HTTP к web-серверам только через ALB

\* Исходящий интернет для private subnet через NAT Gateway



\## 10. Управление конфигурацией



\* Terraform запускается с локальной машины

\* Ansible устанавливается и запускается на bastion host



\## 11. Минимальная структура репозитория



\* terraform/

\* ansible/

\* docs/

\* site/



\## 12. Что нельзя



\* Не использовать IP-адреса в ansible inventory

\* Не хранить токены/ключи облака в git

\* Не назначать web-серверам публичные IP




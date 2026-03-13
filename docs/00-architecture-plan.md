&#x20;Архитектурный план дипломного проекта Yandex Cloud



&#x20;1. Цель проекта



Развернуть отказоустойчивую инфраструктуру сайта в Yandex Cloud с использованием Terraform и Ansible.



&#x20;2. Обязательные компоненты



&#x20;2 web-сервера nginx в разных зонах

&#x20;bastion host

&#x20;Application Load Balancer

&#x20;Zabbix

&#x20;Elasticsearch

&#x20;Kibana

&#x20;Filebeat на web-серверах

&#x20;NAT Gateway для приватного контура

&#x20;Snapshot schedule для всех дисков



&#x20;3. Принятые имена ВМ



&#x20;bastion

&#x20;web-a

&#x20;web-b

&#x20;zabbix

&#x20;elastic

&#x20;kibana



&#x20;4. Ожидаемые внутренние FQDN



&#x20;bastion.ru-central1.internal

&#x20;web-a.ru-central1.internal

&#x20;web-b.ru-central1.internal

&#x20;zabbix.ru-central1.internal

&#x20;elastic.ru-central1.internal

&#x20;kibana.ru-central1.internal



&#x20;5. Размещение по зонам



&#x20;bastion: ru-central1-a

&#x20;web-a: ru-central1-a

&#x20;web-b: ru-central1-b

&#x20;zabbix: ru-central1-a

&#x20;elastic: ru-central1-a

&#x20;kibana: ru-central1-b



&#x20;6. Подсети



&#x20;public-a: 10.10.10.0/24

&#x20;public-b: 10.10.11.0/24

&#x20;private-a: 10.10.20.0/24

&#x20;private-b: 10.10.30.0/24



&#x20;7. Размещение ресурсов по подсетям



&#x20;bastion -> public-a

&#x20;zabbix -> public-a

&#x20;kibana -> public-b

&#x20;ALB -> public-a + public-b

&#x20;web-a -> private-a

&#x20;web-b -> private-b

&#x20;elastic -> private-a



&#x20;8. Публичные IP



&#x20;bastion -> да

&#x20;zabbix -> да

&#x20;kibana -> да

&#x20;web-a -> нет

&#x20;web-b -> нет

&#x20;elastic -> нет



&#x20;9. Доступ



&#x20;SSH к приватным ВМ только через bastion

&#x20;HTTP к web-серверам только через ALB

&#x20;Исходящий интернет для private subnet через NAT Gateway



&#x20;10. Управление конфигурацией



&#x20;Terraform запускается с локальной машины

&#x20;Ansible устанавливается и запускается на bastion host



&#x20;11. Минимальная структура репозитория



&#x20;terraform/

&#x20;ansible/

&#x20;docs/

&#x20;site/



&#x20;12. Что нельзя



&#x20;Не использовать IP-адреса в ansible inventory

&#x20;Не хранить токены/ключи облака в git

&#x20;Не назначать web-серверам публичные IP


resource "yandex_compute_snapshot_schedule" "daily_all_vms" {
  name        = "yc-diplom-daily-snapshots"
  description = "Daily snapshots for all YC diploma VMs with 7-day retention"

  schedule_policy {
    expression = "0 0 * * *"
  }

  retention_period = "168h"

  snapshot_spec {
    description = "Daily snapshot created by schedule for YC diploma"
    labels = {
      project = "yc-diplom"
      type    = "daily-backup"
    }
  }

  labels = {
    project = "yc-diplom"
    env     = "study"
  }

  disk_ids = [
    yandex_compute_instance.bastion.boot_disk[0].disk_id,
    yandex_compute_instance.web_a.boot_disk[0].disk_id,
    yandex_compute_instance.web_b.boot_disk[0].disk_id,
    yandex_compute_instance.zabbix.boot_disk[0].disk_id,
    yandex_compute_instance.elastic.boot_disk[0].disk_id,
    yandex_compute_instance.kibana.boot_disk[0].disk_id,
  ]
}
# Prometheus config
data "template_file" "prometheus_config" {
  template = file("${path.module}/files/prometheus/config.yml")
}


# Grafana datasources config
data "template_file" "grafana_datasource_config" {
  template = file("${path.module}/files/grafana/datasource.yml")
}


# BlackBox config
data "template_file" "blackbox_config" {
  template = file("${path.module}/files/blackbox/config.yml")
}
# Prometheus config
data "template_file" "prometheus_config" {
  template = file("${path.module}/files/prometheus/config.yml")

  vars = {
    site_url = aws_alb.main.dns_name
  }

}


# Grafana datasources config
data "template_file" "grafana_datasource_config" {
  template = file("${path.module}/files/grafana/datasource.yml")
}

# Grafana dashboards config
data "template_file" "grafana_dashboards_config" {
  template = file("${path.module}/files/grafana/dashboards-path.yaml")
}

# Grafana monitor website config json
data "template_file" "grafana_monitor_web_dash" {
  template = file("${path.module}/files/grafana/dashboards-jsons/dashboard.json")
}


# BlackBox config
data "template_file" "blackbox_config" {
  template = file("${path.module}/files/blackbox/config.yml")
}

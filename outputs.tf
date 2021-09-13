# outputs.tf

output "Information" {
  value = [
    {
      nginx_url = format("http://%s", aws_alb.main.dns_name)
    },
    {
      grafana_url = format("http://%s/grafana/", aws_alb.main.dns_name),
      grafana_username = "admin",
      grafana_password = "admin"
    },
    {
      prometheus_url = format("http://%s/prometheus/", aws_alb.main.dns_name)
    }
  ]
}

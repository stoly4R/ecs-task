# logs.tf

# Set up CloudWatch group and log stream and retain logs for 30 days
resource "aws_cloudwatch_log_group" "myapp_log_group" {
  name              = "/ecs/myapp"
  retention_in_days = 30

  tags = {
    Name = "cb-log-group"
  }
}

resource "aws_cloudwatch_log_stream" "myapp_log_stream" {
  name           = "my-log-stream"
  log_group_name = aws_cloudwatch_log_group.myapp_log_group.name
}


resource "aws_cloudwatch_log_group" "grafana_log_group" {
  name              = "/ecs/grafana"
  retention_in_days = 30

  tags = {
    Name = "cb-log-group"
  }
}

resource "aws_cloudwatch_log_stream" "grafana_log_stream" {
  name           = "grafana-log-stream"
  log_group_name = aws_cloudwatch_log_group.grafana_log_group.name
}


resource "aws_cloudwatch_log_group" "prometheus_log_group" {
  name              = "/ecs/prometheus"
  retention_in_days = 30

  tags = {
    Name = "cb-log-group"
  }
}

resource "aws_cloudwatch_log_stream" "prometheus_log_stream" {
  name           = "prometheus-log-stream"
  log_group_name = aws_cloudwatch_log_group.prometheus_log_group.name
}


resource "aws_cloudwatch_log_group" "blackbox_log_group" {
  name              = "/ecs/blackbox"
  retention_in_days = 30

  tags = {
    Name = "cb-log-group"
  }
}

resource "aws_cloudwatch_log_stream" "blackbox_log_stream" {
  name           = "blackbox-log-stream"
  log_group_name = aws_cloudwatch_log_group.blackbox_log_group.name
}

resource "aws_cloudwatch_log_group" "datacopier_log_group" {
  name              = "/ecs/data-copier"
  retention_in_days = 30

  tags = {
    Name = "cb-log-group"
  }
}

resource "aws_cloudwatch_log_stream" "datacopier_log_stream" {
  name           = "data-copier-log-stream"
  log_group_name = aws_cloudwatch_log_group.datacopier_log_group.name
}

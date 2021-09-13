[
  {
    "name": "myapp",
    "image": "${app_image}",
    "cpu": 512,
    "memory": 512,
    "networkMode": "awsvpc",
    "essential": true,
    "dependsOn": [
      {
        "containerName": "data-copier",
        "condition": "SUCCESS"
      }
    ],
    "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "/ecs/myapp",
          "awslogs-region": "${aws_region}",
          "awslogs-stream-prefix": "ecs"
        }
    },
    "portMappings": [
      {
        "containerPort": ${app_port},
        "hostPort": ${app_port},
        "protocol": "tcp"
      }
    ]
  },
  {
    "name": "prometheus",
    "image": "prom/prometheus:v2.29.2",
    "cpu": 512,
    "memory": 512,
    "networkMode": "awsvpc",
    "dependsOn": [
      {
        "containerName": "data-copier",
        "condition": "SUCCESS"
      }
    ],
    "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "/ecs/prometheus",
          "awslogs-region": "${aws_region}",
          "awslogs-stream-prefix": "ecs"
        }
    },
    "command": [
      "--config.file=/etc/configs/prometheus/prometheus.yml",
      "--web.route-prefix=prometheus",
      "--web.external-url=http://${site_url}/prometheus"
    ],
    "entryPoint": null,
    "environment": [],
    "essential": true,
    "memoryReservation": null,
    "mountPoints": [
      {
        "containerPath": "/etc/configs",
        "readOnly": null,
        "sourceVolume": "config"
      },
      {
        "containerPath": "/prometheus/data",
        "readOnly": null,
        "sourceVolume": "prometheus-data"
      }
    ],
    "portMappings": [
      {
        "containerPort": 9090,
        "hostPort": 9090,
        "protocol": "tcp"
      }
    ],
    "volumesFrom": []
  },
  {
    "name": "grafana",
    "image": "grafana/grafana:8.1.2",
    "cpu": 512,
    "memory": 512,
    "networkMode": "awsvpc",
    "dependsOn": [
      {
        "containerName": "data-copier",
        "condition": "SUCCESS"
      }
    ],
    "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "/ecs/grafana",
          "awslogs-region": "${aws_region}",
          "awslogs-stream-prefix": "ecs"
        }
    },
    "command": [],
    "entryPoint": [],
    "environment": [
      {
        "name": "GF_PATHS_PROVISIONING",
        "value": "/etc/configs/grafana"
      },
      {
        "name": "GF_SERVER_ROOT_URL",
        "value": "http://${site_url}/grafana"
      },
      {
        "name": "GF_SERVER_SERVE_FROM_SUB_PATH",
        "value": "true"
      }
	],
    "essential": true,
    "memoryReservation": null,
    "mountPoints": [
      {
        "containerPath": "/etc/configs",
        "readOnly": null,
        "sourceVolume": "config"
      },
      {
        "containerPath": "/var/lib/grafana",
        "readOnly": null,
        "sourceVolume": "grafana-data"
      }
    ],
    "portMappings": [
      {
        "containerPort": 3000,
        "hostPort": 3000,
        "protocol": "tcp"
      }
    ],
    "volumesFrom": []
  },
  {
    "name": "blackbox",
    "image": "prom/blackbox-exporter:v0.19.0",
    "cpu": 512,
    "memory": 512,
    "networkMode": "awsvpc",
    "dependsOn": [
      {
        "containerName": "data-copier",
        "condition": "SUCCESS"
      }
    ],
    "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "/ecs/blackbox",
          "awslogs-region": "${aws_region}",
          "awslogs-stream-prefix": "ecs"
        }
    },
    "command": [
      "--config.file=/etc/configs/blackbox/blackbox.yml"
    ],
    "entryPoint": [],
    "environment": [],
    "essential": true,
    "memoryReservation": null,
    "mountPoints": [
      {
        "containerPath": "/etc/configs",
        "readOnly": null,
        "sourceVolume": "config"
      }
    ],
    "portMappings": [
      {
        "containerPort": 9115,
        "hostPort": 9115,
        "protocol": "tcp"
      }
    ],
    "volumesFrom": []
  },
  {
    "name": "data-copier",
    "image": "centos:7",
    "cpu": 100,
    "memory": 100,
    "networkMode": "awsvpc",
    "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "/ecs/data-copier",
          "awslogs-region": "${aws_region}",
          "awslogs-stream-prefix": "ecs"
        }
    },
    "command": [
      "/bin/sh",
      "-c",
      "mkdir -p /etc/configs/{prometheus,grafana/datasources,grafana/dashboards,grafana/dashboards-jsons,blackbox} && echo $PROMETHEUS_CONFIG|base64 --decode > /etc/configs/prometheus/prometheus.yml && echo $GRAFANA_DATASOURCE_CONFIG|base64 --decode > /etc/configs/grafana/datasources/datasource.yml && echo $GRAFANA_DASHBOARDS_CONFIG|base64 --decode > /etc/configs/grafana/dashboards/dashboards-path.yaml && echo $GRAFANA_MONITOR_WEB_DASH|base64 --decode > /etc/configs/grafana/dashboards-jsons/dashboard.json && echo $BLACKBOX_CONFIG|base64 --decode > /etc/configs/blackbox/blackbox.yml && chmod -R 777 /etc/configs"
    ],
    "entryPoint": [],
    "environment": [
      {
        "name": "PROMETHEUS_CONFIG",
        "value": "${prometheus_config}"
      },
      {
        "name": "GRAFANA_DATASOURCE_CONFIG",
        "value": "${grafana_datasource_config}"
      },
      {
        "name": "GRAFANA_DASHBOARDS_CONFIG",
        "value": "${grafana_dashboards_config}"
      },
      {
        "name": "GRAFANA_MONITOR_WEB_DASH",
        "value": "${grafana_monitor_web_dash}"
      },
      {
        "name": "BLACKBOX_CONFIG",
        "value": "${blackbox_config}"
      }
    ],
    "essential": false,
    "memoryReservation": null,
    "mountPoints": [
      {
        "containerPath": "/etc/configs",
        "readOnly": null,
        "sourceVolume": "config"
      }
    ],
    "volumesFrom": []
  }
]

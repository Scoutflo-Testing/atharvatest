provider "aws" {
  region = var.region
}

resource "aws_ecs_cluster" "this" {
  name = "my-fargate-cluster"
}

resource "aws_ecs_task_definition" "this" {
  family                   = "my-fargate-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 512
  execution_role_arn       = "arn:aws:iam::123456789012:role/ecsTaskExecutionRole"
  container_definitions    = &lt;&lt;-EOT
[
  {
    "name": "my-container",
    "image": "nginx",
    "essential": true,
    "portMappings": [
      {
        "containerPort": 80,
        "hostPort": 80,
        "protocol": "tcp"
      }
    ]
  }
]
EOT
}

resource "aws_ecs_service" "this" {
  name            = "my-fargate-service"
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.this.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  platform_version = "LATEST"

  network_configuration {
    subnets         = var.subnets
    security_groups = [var.security_group_id]
    assign_public_ip = true
  }

  depends_on = [aws_ecs_cluster.this]
}

resource "aws_efs_file_system" "efs_datastore" {
  creation_token = "ecs-efs-fs"

  tags = {
    Name = "ecs-efs-fs"
  }
}

resource "aws_efs_mount_target" "mount" {
  count = length(aws_subnet.private.*.id)
  file_system_id = aws_efs_file_system.efs_datastore.id
  subnet_id      = aws_subnet.private[count.index].id
  security_groups = [aws_security_group.ecs_tasks.id]
}
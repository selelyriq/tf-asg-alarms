# Query all running EC2 instances without tag filtering
data "aws_instances" "running" {
  filter {
    name   = "instance-state-name"
    values = ["running"]
  }

  # No tag filter - will monitor all running instances
}

# Create monitoring for each instance
module "ec2_instance_monitoring" {
  source      = "../ec2_monitoring"
  count       = length(data.aws_instances.running.ids)
  instance_id = data.aws_instances.running.ids[count.index]

  # Basic configuration
  name_prefix = var.name_prefix != "" ? "${var.name_prefix}-${count.index}" : null

  # CPU alarm settings
  cpu_evaluation_periods  = var.cpu_evaluation_periods
  cpu_datapoints_to_alarm = var.cpu_datapoints_to_alarm
  cpu_period              = var.cpu_period
  cpu_threshold_high      = var.cpu_threshold_high

  # Memory alarm settings
  create_memory_alarm       = var.create_memory_alarm
  memory_evaluation_periods = var.memory_evaluation_periods
  memory_period             = var.memory_period
  memory_threshold_high     = var.memory_threshold_high

  # Status check alarms
  create_status_check_alarms      = var.create_status_check_alarms
  status_check_evaluation_periods = var.status_check_evaluation_periods
  status_check_period             = var.status_check_period

  # Actions
  alarm_actions = var.alarm_actions
  ok_actions    = var.ok_actions

  # Tags
  tags = var.tags
} 
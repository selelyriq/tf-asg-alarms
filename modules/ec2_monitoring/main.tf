locals {
  dimensions = {
    InstanceId = var.instance_id
  }
}

module "ec2_alarms" {
  source = "../cloudwatch_alarms"

  # Basic configuration
  alarm_name_prefix = var.name_prefix != "" ? var.name_prefix : "ec2-${var.instance_id}"
  namespace         = "AWS/EC2"
  dimensions        = local.dimensions

  # CPU alarm settings
  cpu_evaluation_periods = var.cpu_evaluation_periods
  cpu_period             = var.cpu_period
  cpu_threshold_high     = var.cpu_threshold_high

  # Memory alarm settings (requires CloudWatch agent)
  create_memory_alarm       = var.create_memory_alarm
  memory_evaluation_periods = var.memory_evaluation_periods
  memory_period             = var.memory_period
  memory_threshold_high     = var.memory_threshold_high

  # EC2 status check alarm settings
  create_status_check_alarms      = var.create_status_check_alarms
  status_check_evaluation_periods = var.status_check_evaluation_periods
  status_check_period             = var.status_check_period

  # Actions
  alarm_actions = var.alarm_actions
  ok_actions    = var.ok_actions

  # Tags
  tags = merge(
    var.tags,
    {
      Instance = var.instance_id
    }
  )
} 
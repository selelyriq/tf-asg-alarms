locals {
  dimensions = {
    AutoScalingGroupName = var.autoscaling_group_name
  }
}

module "asg_alarms" {
  source = "../cloudwatch_alarms"

  # Basic configuration
  alarm_name_prefix = var.alarm_name_prefix != "" ? var.alarm_name_prefix : "asg-${var.autoscaling_group_name}"
  namespace         = "AWS/AutoScaling"
  dimensions        = local.dimensions

  # CPU alarm settings - using GroupAverageCPUUtilization for ASG
  cpu_evaluation_periods  = var.cpu_evaluation_periods
  cpu_datapoints_to_alarm = var.cpu_datapoints_to_alarm
  cpu_period              = var.cpu_period
  cpu_threshold_high      = var.cpu_threshold_high

  # Memory alarm settings (requires CloudWatch agent)
  create_memory_alarm       = var.create_memory_alarm
  memory_evaluation_periods = var.memory_evaluation_periods
  memory_period             = var.memory_period
  memory_threshold_high     = var.memory_threshold_high

  # Skip status check alarms for ASG (not applicable)
  create_status_check_alarms = false

  # Actions
  alarm_actions = var.alarm_actions
  ok_actions    = var.ok_actions

  # Tags
  tags = merge(
    var.tags,
    {
      AutoScalingGroup = var.autoscaling_group_name
    }
  )
} 
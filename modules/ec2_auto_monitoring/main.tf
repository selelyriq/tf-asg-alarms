# Query all Auto Scaling Groups
data "aws_autoscaling_groups" "all" {}

# Create monitoring for each autoscaling group
module "asg_monitoring" {
  source = "../asg_monitoring"
  count  = length(data.aws_autoscaling_groups.all.names)

  autoscaling_group_name = data.aws_autoscaling_groups.all.names[count.index]

  # Basic configuration
  alarm_name_prefix = var.alarm_name_prefix != "" ? "${var.alarm_name_prefix}-${data.aws_autoscaling_groups.all.names[count.index]}" : null

  # CPU alarm settings
  cpu_evaluation_periods  = var.cpu_evaluation_periods
  cpu_datapoints_to_alarm = var.cpu_datapoints_to_alarm
  cpu_period              = var.cpu_period
  cpu_threshold_high      = var.cpu_threshold_high

  # Memory alarm settings (requires CloudWatch agent)
  create_memory_alarm       = var.create_memory_alarm
  memory_evaluation_periods = var.memory_evaluation_periods
  memory_period             = var.memory_period
  memory_threshold_high     = var.memory_threshold_high

  # Actions
  alarm_actions = var.alarm_actions
  ok_actions    = var.ok_actions

  # Tags
  tags = var.tags
} 
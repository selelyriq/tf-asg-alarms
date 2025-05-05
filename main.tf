provider "aws" {
  region = var.aws_region
}

module "cloudwatch_alarms" {
  source = "./modules/cloudwatch_alarms"

  # Basic configuration
  alarm_name_prefix = var.alarm_name_prefix
  namespace         = var.namespace
  dimensions        = var.dimensions

  # CPU alarm settings
  cpu_evaluation_periods = var.cpu_evaluation_periods
  cpu_period             = var.cpu_period
  cpu_threshold_high     = var.cpu_threshold_high

  # Memory alarm settings
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
  tags = var.tags
}

resource "aws_cloudwatch_metric_alarm" "cpu_high" {
  alarm_name          = "${var.alarm_name_prefix}-cpu-utilization-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.cpu_evaluation_periods
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = var.cpu_period
  statistic           = "Average"
  threshold           = var.cpu_threshold_high
  alarm_description   = "This metric monitors high CPU utilization"
  alarm_actions       = var.alarm_actions
  ok_actions          = var.ok_actions
  tags                = var.tags

  # Treat missing data as not breaching
  treat_missing_data = "notBreaching"
  # Evaluate as many data points as are available
  datapoints_to_alarm = var.cpu_datapoints_to_alarm > 0 ? var.cpu_datapoints_to_alarm : var.cpu_evaluation_periods

  dimensions = var.dimensions
}

resource "aws_cloudwatch_metric_alarm" "memory_high" {
  count = var.create_memory_alarm ? 1 : 0

  alarm_name          = "${var.alarm_name_prefix}-memory-utilization-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.memory_evaluation_periods
  metric_name         = "MemoryUtilization"
  namespace           = var.namespace
  period              = var.memory_period
  statistic           = "Average"
  threshold           = var.memory_threshold_high
  alarm_description   = "This metric monitors high memory utilization"
  alarm_actions       = var.alarm_actions
  ok_actions          = var.ok_actions
  tags                = var.tags

  # Treat missing data as not breaching
  treat_missing_data = "notBreaching"

  dimensions = var.dimensions
}

resource "aws_cloudwatch_metric_alarm" "status_check_failed" {
  count = var.create_status_check_alarms ? 1 : 0

  alarm_name          = "${var.alarm_name_prefix}-status-check-failed"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = var.status_check_evaluation_periods
  metric_name         = "StatusCheckFailed"
  namespace           = "AWS/EC2"
  period              = var.status_check_period
  statistic           = "Maximum"
  threshold           = 1
  alarm_description   = "This metric monitors EC2 status checks"
  alarm_actions       = var.alarm_actions
  ok_actions          = var.ok_actions
  tags                = var.tags

  # Treat missing data as breaching for status checks
  treat_missing_data = "breaching"

  dimensions = var.dimensions
}

resource "aws_cloudwatch_metric_alarm" "status_check_failed_system" {
  count = var.create_status_check_alarms ? 1 : 0

  alarm_name          = "${var.alarm_name_prefix}-status-check-failed-system"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = var.status_check_evaluation_periods
  metric_name         = "StatusCheckFailed_System"
  namespace           = "AWS/EC2"
  period              = var.status_check_period
  statistic           = "Maximum"
  threshold           = 1
  alarm_description   = "This metric monitors EC2 system status checks"
  alarm_actions       = var.alarm_actions
  ok_actions          = var.ok_actions
  tags                = var.tags

  # Treat missing data as breaching for status checks
  treat_missing_data = "breaching"

  dimensions = var.dimensions
}

resource "aws_cloudwatch_metric_alarm" "status_check_failed_instance" {
  count = var.create_status_check_alarms ? 1 : 0

  alarm_name          = "${var.alarm_name_prefix}-status-check-failed-instance"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = var.status_check_evaluation_periods
  metric_name         = "StatusCheckFailed_Instance"
  namespace           = "AWS/EC2"
  period              = var.status_check_period
  statistic           = "Maximum"
  threshold           = 1
  alarm_description   = "This metric monitors EC2 instance status checks"
  alarm_actions       = var.alarm_actions
  ok_actions          = var.ok_actions
  tags                = var.tags

  # Treat missing data as breaching for status checks
  treat_missing_data = "breaching"

  dimensions = var.dimensions
} 
output "cpu_alarm_id" {
  description = "The ID of the CPU high utilization CloudWatch alarm"
  value       = aws_cloudwatch_metric_alarm.cpu_high.id
}

output "cpu_alarm_arn" {
  description = "The ARN of the CPU high utilization CloudWatch alarm"
  value       = aws_cloudwatch_metric_alarm.cpu_high.arn
}

output "memory_alarm_id" {
  description = "The ID of the Memory high utilization CloudWatch alarm"
  value       = var.create_memory_alarm ? aws_cloudwatch_metric_alarm.memory_high[0].id : null
}

output "memory_alarm_arn" {
  description = "The ARN of the Memory high utilization CloudWatch alarm"
  value       = var.create_memory_alarm ? aws_cloudwatch_metric_alarm.memory_high[0].arn : null
}

output "status_check_failed_alarm_id" {
  description = "The ID of the EC2 StatusCheckFailed CloudWatch alarm"
  value       = var.create_status_check_alarms ? aws_cloudwatch_metric_alarm.status_check_failed[0].id : null
}

output "status_check_failed_alarm_arn" {
  description = "The ARN of the EC2 StatusCheckFailed CloudWatch alarm"
  value       = var.create_status_check_alarms ? aws_cloudwatch_metric_alarm.status_check_failed[0].arn : null
}

output "status_check_failed_system_alarm_id" {
  description = "The ID of the EC2 StatusCheckFailed_System CloudWatch alarm"
  value       = var.create_status_check_alarms ? aws_cloudwatch_metric_alarm.status_check_failed_system[0].id : null
}

output "status_check_failed_system_alarm_arn" {
  description = "The ARN of the EC2 StatusCheckFailed_System CloudWatch alarm"
  value       = var.create_status_check_alarms ? aws_cloudwatch_metric_alarm.status_check_failed_system[0].arn : null
}

output "status_check_failed_instance_alarm_id" {
  description = "The ID of the EC2 StatusCheckFailed_Instance CloudWatch alarm"
  value       = var.create_status_check_alarms ? aws_cloudwatch_metric_alarm.status_check_failed_instance[0].id : null
}

output "status_check_failed_instance_alarm_arn" {
  description = "The ARN of the EC2 StatusCheckFailed_Instance CloudWatch alarm"
  value       = var.create_status_check_alarms ? aws_cloudwatch_metric_alarm.status_check_failed_instance[0].arn : null
} 
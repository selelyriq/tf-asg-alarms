output "cpu_alarm_arn" {
  description = "ARN of the CPU utilization alarm"
  value       = module.asg_alarms.cpu_alarm_arn
}

output "memory_alarm_arn" {
  description = "ARN of the memory utilization alarm (if enabled)"
  value       = module.asg_alarms.memory_alarm_arn
}

output "autoscaling_group_name" {
  description = "Name of the Auto Scaling Group being monitored"
  value       = var.autoscaling_group_name
}

output "alarm_name_prefix" {
  description = "Prefix used for alarm names"
  value       = var.alarm_name_prefix != "" ? var.alarm_name_prefix : "asg-${var.autoscaling_group_name}"
} 
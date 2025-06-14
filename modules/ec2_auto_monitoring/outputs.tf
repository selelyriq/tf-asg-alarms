output "monitored_asg_names" {
  description = "List of Auto Scaling Group names being monitored"
  value       = data.aws_autoscaling_groups.all.names
}

output "monitored_asg_count" {
  description = "Number of Auto Scaling Groups being monitored"
  value       = length(data.aws_autoscaling_groups.all.names)
}

output "cpu_alarm_arns" {
  description = "List of CPU alarm ARNs created for Auto Scaling Groups"
  value       = [for i in module.asg_monitoring : i.cpu_alarm_arn]
}

output "memory_alarm_arns" {
  description = "List of Memory alarm ARNs created for Auto Scaling Groups (if enabled)"
  value       = var.create_memory_alarm ? [for i in module.asg_monitoring : i.memory_alarm_arn] : []
}

output "alarm_name_prefixes" {
  description = "List of alarm name prefixes used for Auto Scaling Groups"
  value       = [for i in module.asg_monitoring : i.alarm_name_prefix]
} 
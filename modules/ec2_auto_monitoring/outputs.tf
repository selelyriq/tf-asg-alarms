output "monitored_instance_ids" {
  description = "List of EC2 instance IDs being monitored"
  value       = data.aws_instances.running.ids
}

output "monitored_instances_count" {
  description = "Number of EC2 instances being monitored"
  value       = length(data.aws_instances.running.ids)
}

output "cpu_alarm_arns" {
  description = "List of CPU alarm ARNs created for instances"
  value       = [for i in module.ec2_instance_monitoring : i.cpu_alarm_arn]
}

output "status_check_failed_alarm_arns" {
  description = "List of Status Check Failed alarm ARNs created for instances"
  value       = [for i in module.ec2_instance_monitoring : i.status_check_failed_alarm_arn]
}

output "memory_alarm_arns" {
  description = "List of Memory alarm ARNs created for instances (if enabled)"
  value       = var.create_memory_alarm ? [for i in module.ec2_instance_monitoring : i.memory_alarm_arn] : []
} 
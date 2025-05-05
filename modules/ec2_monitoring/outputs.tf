output "cpu_alarm_id" {
  description = "The ID of the CPU high utilization CloudWatch alarm"
  value       = module.ec2_alarms.cpu_alarm_id
}

output "cpu_alarm_arn" {
  description = "The ARN of the CPU high utilization CloudWatch alarm"
  value       = module.ec2_alarms.cpu_alarm_arn
}

output "memory_alarm_id" {
  description = "The ID of the Memory high utilization CloudWatch alarm"
  value       = module.ec2_alarms.memory_alarm_id
}

output "memory_alarm_arn" {
  description = "The ARN of the Memory high utilization CloudWatch alarm"
  value       = module.ec2_alarms.memory_alarm_arn
}

output "status_check_failed_alarm_id" {
  description = "The ID of the StatusCheckFailed CloudWatch alarm"
  value       = module.ec2_alarms.status_check_failed_alarm_id
}

output "status_check_failed_alarm_arn" {
  description = "The ARN of the StatusCheckFailed CloudWatch alarm"
  value       = module.ec2_alarms.status_check_failed_alarm_arn
}

output "status_check_failed_system_alarm_id" {
  description = "The ID of the StatusCheckFailed_System CloudWatch alarm"
  value       = module.ec2_alarms.status_check_failed_system_alarm_id
}

output "status_check_failed_system_alarm_arn" {
  description = "The ARN of the StatusCheckFailed_System CloudWatch alarm"
  value       = module.ec2_alarms.status_check_failed_system_alarm_arn
}

output "status_check_failed_instance_alarm_id" {
  description = "The ID of the StatusCheckFailed_Instance CloudWatch alarm"
  value       = module.ec2_alarms.status_check_failed_instance_alarm_id
}

output "status_check_failed_instance_alarm_arn" {
  description = "The ARN of the StatusCheckFailed_Instance CloudWatch alarm"
  value       = module.ec2_alarms.status_check_failed_instance_alarm_arn
}

output "instance_id" {
  description = "The EC2 instance ID being monitored"
  value       = var.instance_id
} 
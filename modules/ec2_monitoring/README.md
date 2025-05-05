# EC2 Monitoring Module

This Terraform module creates CloudWatch alarms for monitoring EC2 instances based on best practices.

## Resources Created

- CPU Utilization alarm
- Memory Utilization alarm (optional - requires CloudWatch Agent)
- Status Check Failed alarm
- Status Check Failed System alarm
- Status Check Failed Instance alarm

## Usage

```hcl
module "ec2_monitoring" {
  source = "path/to/modules/ec2_monitoring"

  instance_id = "i-1234567890abcdef0"
  
  # Optional custom settings
  name_prefix      = "prod-webapp"
  cpu_threshold_high = 75
  
  # Enable status check alarms (enabled by default)
  create_status_check_alarms = true
  
  # Actions
  alarm_actions = ["arn:aws:sns:us-east-1:123456789012:my-topic"]
  
  # Tags
  tags = {
    Environment = "Production"
    Application = "WebApp"
  }
}
```

## Memory Monitoring

To enable memory monitoring for EC2 instances, you need to:

1. Install the CloudWatch agent on your EC2 instances
2. Configure the agent to collect memory metrics
3. Set `create_memory_alarm = true` when calling this module

## Input Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| instance_id | ID of the EC2 instance to monitor | string | | yes |
| name_prefix | Prefix for alarm names | string | "" | no |
| cpu_evaluation_periods | Number of periods to evaluate for the CPU alarm | number | 2 | no |
| cpu_period | Period in seconds for the CPU alarm evaluation | number | 300 | no |
| cpu_threshold_high | CPU utilization threshold for high alarm | number | 80 | no |
| create_memory_alarm | Whether to create memory utilization alarm | bool | false | no |
| memory_evaluation_periods | Number of periods to evaluate for the memory alarm | number | 2 | no |
| memory_period | Period in seconds for the memory alarm evaluation | number | 300 | no |
| memory_threshold_high | Memory utilization threshold for high alarm | number | 80 | no |
| create_status_check_alarms | Whether to create EC2 status check alarms | bool | true | no |
| status_check_evaluation_periods | Number of periods to evaluate for status check alarms | number | 1 | no |
| status_check_period | Period in seconds for status check alarm evaluation | number | 60 | no |
| alarm_actions | List of ARNs to notify when alarm transitions to ALARM state | list(string) | [] | no |
| ok_actions | List of ARNs to notify when alarm transitions to OK state | list(string) | [] | no |
| tags | Tags to apply to all resources | map(string) | {} | no |

## Outputs

| Name | Description |
|------|-------------|
| cpu_alarm_id | The ID of the CPU high utilization CloudWatch alarm |
| cpu_alarm_arn | The ARN of the CPU high utilization CloudWatch alarm |
| memory_alarm_id | The ID of the Memory high utilization CloudWatch alarm |
| memory_alarm_arn | The ARN of the Memory high utilization CloudWatch alarm |
| status_check_failed_alarm_id | The ID of the StatusCheckFailed CloudWatch alarm |
| status_check_failed_alarm_arn | The ARN of the StatusCheckFailed CloudWatch alarm |
| status_check_failed_system_alarm_id | The ID of the StatusCheckFailed_System CloudWatch alarm |
| status_check_failed_system_alarm_arn | The ARN of the StatusCheckFailed_System CloudWatch alarm |
| status_check_failed_instance_alarm_id | The ID of the StatusCheckFailed_Instance CloudWatch alarm |
| status_check_failed_instance_alarm_arn | The ARN of the StatusCheckFailed_Instance CloudWatch alarm |
| instance_id | The EC2 instance ID being monitored | 
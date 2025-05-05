# EC2 Auto-Monitoring Module

This Terraform module automatically discovers running EC2 instances and creates CloudWatch alarms to monitor them.

## Auto-Discovery

The module uses the `aws_instances` data source to find all running EC2 instances in your account and region. It then creates CloudWatch alarms for each discovered instance.

## Resources Created (Per Instance)

- CPU Utilization alarm
- Memory Utilization alarm (optional - requires CloudWatch Agent)
- Status Check Failed alarm
- Status Check Failed System alarm
- Status Check Failed Instance alarm

## Usage

```hcl
module "ec2_auto_monitoring" {
  source = "path/to/modules/ec2_auto_monitoring"
  
  # Optional custom settings
  name_prefix      = "prod"
  cpu_threshold_high = 80
  
  # Actions
  alarm_actions = ["arn:aws:sns:us-east-1:123456789012:my-topic"]
  
  # Tags
  tags = {
    Environment = "Production"
    Application = "WebApp"
  }
}
```

## Requirements for Auto-Discovery

For EC2 instances to be discovered and monitored, they must be in the `running` state. All running instances in your AWS account (in the region where you apply this module) will be monitored.

## Memory Monitoring

To enable memory monitoring, you need to:

1. Install the CloudWatch agent on your EC2 instances
2. Configure the agent to collect memory metrics
3. Set `create_memory_alarm = true` when calling this module

## Input Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| name_prefix | Prefix for alarm names | string | "" | no |
| cpu_evaluation_periods | Number of periods to evaluate for the CPU alarm | number | 2 | no |
| cpu_datapoints_to_alarm | Number of datapoints that must be breaching to trigger the CPU alarm | number | 0 | no |
| cpu_period | Period in seconds for the CPU alarm evaluation | number | 300 | no |
| cpu_threshold_high | CPU utilization threshold for high alarm (percentage, fixed at 80% if not specified) | number | 80 | no |
| create_memory_alarm | Whether to create memory utilization alarm | bool | false | no |
| memory_evaluation_periods | Number of periods to evaluate for the memory alarm | number | 2 | no |
| memory_period | Period in seconds for the memory alarm evaluation | number | 300 | no |
| memory_threshold_high | Memory utilization threshold for high alarm (percentage) | number | 80 | no |
| create_status_check_alarms | Whether to create EC2 status check alarms | bool | true | no |
| status_check_evaluation_periods | Number of periods to evaluate for status check alarms | number | 1 | no |
| status_check_period | Period in seconds for status check alarm evaluation | number | 60 | no |
| alarm_actions | List of ARNs to notify when alarm transitions to ALARM state | list(string) | [] | no |
| ok_actions | List of ARNs to notify when alarm transitions to OK state | list(string) | [] | no |
| tags | Tags to apply to all resources | map(string) | {} | no |

## Outputs

| Name | Description |
|------|-------------|
| monitored_instance_ids | List of EC2 instance IDs being monitored |
| monitored_instances_count | Number of EC2 instances being monitored |
| cpu_alarm_arns | List of CPU alarm ARNs created for instances |
| status_check_failed_alarm_arns | List of Status Check Failed alarm ARNs created for instances |
| memory_alarm_arns | List of Memory alarm ARNs created for instances (if enabled) | 
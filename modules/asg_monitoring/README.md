# Auto Scaling Group Monitoring Module

This Terraform module creates CloudWatch alarms for monitoring an Auto Scaling Group (ASG).

## Features

- **CPU Utilization Monitoring**: Monitors the average CPU utilization across all instances in the ASG using the `GroupAverageCPUUtilization` metric
- **Memory Utilization Monitoring**: Optionally monitors average memory utilization (requires CloudWatch agent installed on instances)
- **Flexible Configuration**: Configurable thresholds, evaluation periods, and alarm actions
- **Tagging Support**: Applies tags to all created resources

## Metrics Used

### Auto Scaling Group Metrics (AWS/AutoScaling namespace)
- `GroupAverageCPUUtilization` - Average CPU utilization across all instances in the ASG
- `GroupAverageMemoryUtilization` - Average memory utilization across all instances in the ASG (requires CloudWatch agent)

## Usage

```hcl
module "asg_monitoring" {
  source = "./modules/asg_monitoring"
  
  autoscaling_group_name = "my-asg"
  name_prefix           = "production"
  
  # CPU alarm settings
  cpu_threshold_high     = 80
  cpu_evaluation_periods = 2
  cpu_period            = 300
  
  # Memory alarm settings (optional)
  create_memory_alarm      = true
  memory_threshold_high    = 80
  memory_evaluation_periods = 2
  memory_period           = 300
  
  # Notification settings
  alarm_actions = [aws_sns_topic.alerts.arn]
  ok_actions    = [aws_sns_topic.alerts.arn]
  
  tags = {
    Environment = "production"
    Team        = "platform"
  }
}
```

## Requirements

- Terraform >= 0.12
- AWS provider >= 3.0
- Auto Scaling Group must exist
- For memory monitoring: CloudWatch agent must be installed and configured on instances

## Important Notes

1. **CloudWatch Agent Required for Memory**: Memory utilization monitoring requires the CloudWatch agent to be installed and properly configured on the instances in your Auto Scaling Group.

2. **Metric Availability**: Auto Scaling Group metrics are only available when the ASG has running instances. Alarms may show "Insufficient Data" when the ASG is scaled to zero.

3. **Billing**: CloudWatch alarms incur charges. See AWS CloudWatch pricing for details.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| autoscaling_group_name | Name of the Auto Scaling Group to monitor | `string` | n/a | yes |
| name_prefix | Prefix for alarm names | `string` | `""` | no |
| cpu_evaluation_periods | Number of periods to evaluate for the CPU alarm | `number` | `2` | no |
| cpu_datapoints_to_alarm | Number of datapoints that must be breaching to trigger the CPU alarm | `number` | `0` | no |
| cpu_period | Period in seconds for the CPU alarm evaluation | `number` | `300` | no |
| cpu_threshold_high | CPU utilization threshold for high alarm (percentage) | `number` | `80` | no |
| create_memory_alarm | Whether to create memory utilization alarm | `bool` | `false` | no |
| memory_evaluation_periods | Number of periods to evaluate for the memory alarm | `number` | `2` | no |
| memory_period | Period in seconds for the memory alarm evaluation | `number` | `300` | no |
| memory_threshold_high | Memory utilization threshold for high alarm (percentage) | `number` | `80` | no |
| alarm_actions | List of ARNs to notify when alarm transitions to ALARM state | `list(string)` | `[]` | no |
| ok_actions | List of ARNs to notify when alarm transitions to OK state | `list(string)` | `[]` | no |
| tags | Tags to apply to all resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| cpu_alarm_arn | ARN of the CPU utilization alarm |
| memory_alarm_arn | ARN of the memory utilization alarm (if enabled) |
| autoscaling_group_name | Name of the Auto Scaling Group being monitored |
| alarm_name_prefix | Prefix used for alarm names 
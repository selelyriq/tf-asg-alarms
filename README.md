# AWS Auto Scaling Group CloudWatch Alarms Terraform Module

This Terraform module creates AWS CloudWatch alarms for monitoring Auto Scaling Groups (ASGs). It automatically discovers all ASGs in your account and creates CPU utilization alarms, and optionally memory utilization alarms for each ASG.

## Features

- **Automatic Discovery**: Automatically finds and monitors all Auto Scaling Groups in your AWS account
- **Group-level Monitoring**: Monitors average CPU utilization across all instances in each ASG using `GroupAverageCPUUtilization`
- **Optional Memory Monitoring**: Monitors average memory utilization across ASG instances (requires CloudWatch agent)
- **Flexible Configuration**: Configurable thresholds, evaluation periods, and alarm actions
- **Tagging Support**: Applies tags to all created resources
- **Scalable**: Works with any number of Auto Scaling Groups

## Usage

```hcl
module "ec2_auto_monitoring" {
  source = "./modules/ec2_auto_monitoring"

  # Basic configuration
  name_prefix = "production"
  
  # CPU alarm settings
  cpu_evaluation_periods  = 2
  cpu_datapoints_to_alarm = 2
  cpu_period              = 300
  cpu_threshold_high      = 80
  
  # Memory alarm settings (optional)
  create_memory_alarm       = true
  memory_evaluation_periods = 2
  memory_period             = 300
  memory_threshold_high     = 80
  
  # Actions
  alarm_actions = ["arn:aws:sns:us-east-1:123456789012:my-topic"]
  ok_actions    = ["arn:aws:sns:us-east-1:123456789012:my-topic"]
  
  # Tags
  tags = {
    Environment = "Production"
    Project     = "MyApp"
  }
}
```

This will automatically create alarms for all Auto Scaling Groups in your AWS account. The module will:
1. Discover all existing Auto Scaling Groups
2. Create CPU utilization alarms for each ASG
3. Optionally create memory utilization alarms (if enabled)
4. Use the naming convention: `{name_prefix}-{asg_name}-cpu-utilization-high`

## Input Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| name_prefix | Prefix for alarm names | string | "" | no |
| cpu_evaluation_periods | Number of periods to evaluate for the CPU alarm | number | 2 | no |
| cpu_datapoints_to_alarm | Number of datapoints that must be breaching to trigger the CPU alarm (if 0, uses evaluation_periods) | number | 0 | no |
| cpu_period | Period in seconds for the CPU alarm evaluation | number | 300 | no |
| cpu_threshold_high | CPU utilization threshold for high alarm (percentage) | number | 80 | no |
| create_memory_alarm | Whether to create memory utilization alarm (requires CloudWatch agent) | bool | false | no |
| memory_evaluation_periods | Number of periods to evaluate for the memory alarm | number | 2 | no |
| memory_period | Period in seconds for the memory alarm evaluation | number | 300 | no |
| memory_threshold_high | Memory utilization threshold for high alarm (percentage) | number | 80 | no |
| alarm_actions | List of ARNs to notify when alarm transitions to ALARM state | list(string) | [] | no |
| ok_actions | List of ARNs to notify when alarm transitions to OK state | list(string) | [] | no |
| tags | Tags to apply to all resources | map(string) | {} | no |

## Outputs

| Name | Description |
|------|-------------|
| monitored_asg_names | List of Auto Scaling Group names being monitored |
| monitored_asg_count | Number of Auto Scaling Groups being monitored |
| cpu_alarm_arns | List of CPU alarm ARNs created for Auto Scaling Groups |
| memory_alarm_arns | List of Memory alarm ARNs created for Auto Scaling Groups (if enabled) |
| alarm_name_prefixes | List of alarm name prefixes used for Auto Scaling Groups |

## Important Notes

1. **Automatic Discovery**: The module automatically discovers all Auto Scaling Groups in your AWS account. No need to specify individual ASG names.

2. **CloudWatch Agent Required for Memory**: Memory utilization monitoring requires the CloudWatch agent to be installed and properly configured on all instances in your Auto Scaling Groups.

3. **Metric Availability**: Auto Scaling Group metrics are only available when the ASG has running instances. Alarms may show "Insufficient Data" when ASGs are scaled to zero.

4. **IAM Permissions**: Ensure your Terraform execution role has permissions for:
   - `autoscaling:DescribeAutoScalingGroups`
   - `cloudwatch:PutMetricAlarm`
   - `cloudwatch:DeleteAlarms`
   - `cloudwatch:DescribeAlarms`

5. **Billing**: CloudWatch alarms incur charges. This module may create multiple alarms (2 per ASG if memory monitoring is enabled).

## Handling Missing Data

This module is configured to handle missing data appropriately for Auto Scaling Groups:

- **CPU and memory alarms**: Missing data is treated as "notBreaching" (alarm will remain in OK state if no data is reported)
- **Auto Scaling Group behavior**: When an ASG is scaled to zero instances, no metrics are reported, causing alarms to show "Insufficient Data"

To reduce "Insufficient Data" states, the module uses:
1. Appropriate `treat_missing_data` settings optimized for ASG metrics
2. Configurable `datapoints_to_alarm` to allow for proper evaluation of group metrics
3. Default metric periods and evaluation periods optimized for Auto Scaling Group monitoring
4. Uses `GroupAverageCPUUtilization` and `GroupAverageMemoryUtilization` metrics which are more stable for group-level monitoring

## Metrics Used

- **CPU**: `GroupAverageCPUUtilization` from `AWS/AutoScaling` namespace
- **Memory**: `GroupAverageMemoryUtilization` from `AWS/AutoScaling` namespace (requires CloudWatch agent)
# tf-asg-alarms

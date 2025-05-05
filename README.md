# AWS CloudWatch Alarms Terraform Module

This Terraform module creates AWS CloudWatch alarms for monitoring resources. By default, it creates CPU utilization alarms, and optionally memory utilization alarms.

## Features

- CPU utilization alarm with configurable thresholds
- Optional memory utilization alarm
- Customizable alarm actions and dimensions
- Tagging support

## Usage

```hcl
module "cloudwatch_alarms" {
  source = "./modules/cloudwatch_alarms"

  # Basic configuration
  alarm_name_prefix = "my-app"
  namespace         = "AWS/EC2"
  dimensions        = {
    InstanceId = "i-1234567890abcdef0"
  }
  
  # CPU alarm settings
  cpu_evaluation_periods = 2
  cpu_datapoints_to_alarm = 1
  cpu_period             = 300
  cpu_threshold_high     = 80
  
  # Memory alarm settings (optional)
  create_memory_alarm      = true
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

## Input Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| alarm_name_prefix | Prefix for CloudWatch alarm names | string | "cw-alarm" | no |
| namespace | CloudWatch namespace for the alarms | string | "AWS/EC2" | no |
| dimensions | Dimensions for the alarm | map(string) | {} | no |
| cpu_evaluation_periods | Number of periods to evaluate for the CPU alarm | number | 2 | no |
| cpu_datapoints_to_alarm | Number of datapoints that must be breaching to trigger the CPU alarm | number | 1 | no |
| cpu_period | Period in seconds for the CPU alarm evaluation | number | 300 | no |
| cpu_threshold_high | CPU utilization threshold for high alarm (percentage, fixed at 80% if not specified) | number | 80 | no |
| create_memory_alarm | Whether to create memory utilization alarm | bool | false | no |
| memory_evaluation_periods | Number of periods to evaluate for the memory alarm | number | 2 | no |
| memory_period | Period in seconds for the memory alarm evaluation | number | 300 | no |
| memory_threshold_high | Memory utilization threshold for high alarm (percentage) | number | 80 | no |
| create_status_check_alarms | Whether to create EC2 status check alarms | bool | false | no |
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

## Notes

- For memory metrics on EC2 instances, you may need to set up CloudWatch agent
- Use appropriate IAM permissions for CloudWatch operations # tf-alarms

## Handling Missing Data

This module is configured to handle missing data appropriately:

- For CPU and memory alarms: missing data is treated as "notBreaching" (alarm will remain in OK state if no data is reported)
- For status check alarms: missing data is treated as "breaching" (alarm will go to ALARM state if no data is reported, as this indicates a potential issue with the instance)

To reduce "Insufficient Data" states, the module uses a combination of:
1. Appropriate `treat_missing_data` settings
2. Configurable `datapoints_to_alarm` to allow for proper evaluation
3. Default metric periods and evaluation periods optimized for each metric type

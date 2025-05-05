# CloudWatch Alarms Module

This module creates AWS CloudWatch alarms for resource monitoring.

## Resources Created

- CloudWatch alarms for CPU utilization
- Optional CloudWatch alarms for memory utilization

## Usage

```hcl
module "cloudwatch_alarms" {
  source = "path/to/modules/cloudwatch_alarms"

  alarm_name_prefix = "my-ec2"
  namespace         = "AWS/EC2"
  dimensions        = {
    InstanceId = "i-1234567890abcdef0"
  }
  
  # CPU alarm settings
  cpu_threshold_high = 90
  
  # Optional memory alarm
  create_memory_alarm = true
  
  # Actions
  alarm_actions = ["arn:aws:sns:us-east-1:123456789012:alert-topic"]
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13.0 |
| aws | >= 3.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 3.0 |

## Notes

For information about CloudWatch metrics and dimensions, refer to the [AWS CloudWatch documentation](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/aws-services-cloudwatch-metrics.html). 
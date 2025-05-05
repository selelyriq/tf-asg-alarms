provider "aws" {
  region = "us-east-1"
}

# Example EC2 instance
resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  tags = {
    Name = "example-instance"
  }
}

# Create SNS topic for notifications
resource "aws_sns_topic" "alerts" {
  name = "ec2-monitoring-alerts"
}

# Subscribe email to the SNS topic
resource "aws_sns_topic_subscription" "email_alerts" {
  topic_arn = aws_sns_topic.alerts.arn
  protocol  = "email"
  endpoint  = "alerts@example.com"
}

# Apply monitoring to the EC2 instance
module "ec2_monitoring" {
  source = "../../modules/ec2_monitoring"

  instance_id = aws_instance.example.id
  name_prefix = "example-app"

  # CPU alarm configuration
  cpu_threshold_high     = 75
  cpu_evaluation_periods = 3
  cpu_period             = 60 # 1 minute

  # Status check alarms
  create_status_check_alarms = true

  # Memory monitoring (requires CloudWatch agent on the instance)
  create_memory_alarm   = true
  memory_threshold_high = 85

  # Alert actions
  alarm_actions = [aws_sns_topic.alerts.arn]
  ok_actions    = [aws_sns_topic.alerts.arn]

  # Tags
  tags = {
    Environment = "Example"
    Monitoring  = "CloudWatch"
  }
}

# Output the alarm ARNs
output "cpu_alarm_arn" {
  value = module.ec2_monitoring.cpu_alarm_arn
}

output "status_check_failed_alarm_arn" {
  value = module.ec2_monitoring.status_check_failed_alarm_arn
} 
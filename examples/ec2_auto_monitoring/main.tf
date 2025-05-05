provider "aws" {
  region = "us-east-1"
}

# Example EC2 instances - all will be monitored regardless of tags
resource "aws_instance" "web_servers" {
  count         = 3
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  tags = {
    Name    = "web-server-${count.index + 1}"
    Service = "WebApp"
  }
}

# This instance will also be monitored automatically
resource "aws_instance" "test_server" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  tags = {
    Name    = "test-server"
    Service = "Testing"
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
  endpoint  = "lyriqsele@example.com"
}

# Apply monitoring to all running EC2 instances
module "ec2_auto_monitoring" {
  source = "../../modules/ec2_auto_monitoring"

  name_prefix = "prod"

  # CPU alarm configuration - hard threshold at 80%
  cpu_threshold_high      = 80
  cpu_evaluation_periods  = 3
  cpu_datapoints_to_alarm = 2  # Only need 2 out of 3 datapoints to trigger
  cpu_period              = 60 # 1 minute

  # Status check alarms (enabled by default)
  create_status_check_alarms = true

  # Memory monitoring (requires CloudWatch agent on the instances)
  create_memory_alarm = false # Set to true if CloudWatch agent is installed

  # Alert actions
  alarm_actions = [aws_sns_topic.alerts.arn]
  ok_actions    = [aws_sns_topic.alerts.arn]

  # Tags
  tags = {
    Environment = "Production"
    ManagedBy   = "Terraform"
  }
}

# Outputs
output "monitored_instances" {
  description = "List of EC2 instance IDs being monitored"
  value       = module.ec2_auto_monitoring.monitored_instance_ids
}

output "monitored_instances_count" {
  description = "Number of EC2 instances being monitored"
  value       = module.ec2_auto_monitoring.monitored_instances_count
}

output "cpu_alarm_arns" {
  description = "List of CPU alarm ARNs"
  value       = module.ec2_auto_monitoring.cpu_alarm_arns
} 
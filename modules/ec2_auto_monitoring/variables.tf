variable "name_prefix" {
  description = "Prefix for alarm names"
  type        = string
  default     = ""
}

variable "cpu_evaluation_periods" {
  description = "Number of periods to evaluate for the CPU alarm"
  type        = number
  default     = 2
}

variable "cpu_datapoints_to_alarm" {
  description = "Number of datapoints that must be breaching to trigger the CPU alarm (if 0, uses the same value as evaluation_periods)"
  type        = number
  default     = 0
}

variable "cpu_period" {
  description = "Period in seconds for the CPU alarm evaluation"
  type        = number
  default     = 300
}

variable "cpu_threshold_high" {
  description = "CPU utilization threshold for high alarm (percentage, fixed at 80% if not specified)"
  type        = number
  default     = 80
}

variable "create_memory_alarm" {
  description = "Whether to create memory utilization alarm (requires CloudWatch agent)"
  type        = bool
  default     = false
}

variable "memory_evaluation_periods" {
  description = "Number of periods to evaluate for the memory alarm"
  type        = number
  default     = 2
}

variable "memory_period" {
  description = "Period in seconds for the memory alarm evaluation"
  type        = number
  default     = 300
}

variable "memory_threshold_high" {
  description = "Memory utilization threshold for high alarm (percentage)"
  type        = number
  default     = 80
}

# Status check alarms are not applicable to Auto Scaling Groups
# as they operate at the group level rather than individual instance level

variable "alarm_actions" {
  description = "List of ARNs to notify when alarm transitions to ALARM state"
  type        = list(string)
  default     = []
}

variable "ok_actions" {
  description = "List of ARNs to notify when alarm transitions to OK state"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
} 
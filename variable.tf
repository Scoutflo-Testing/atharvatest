variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}

variable "subnets" {
  description = "List of subnets where Fargate tasks should run"
  type        = list(string)
  default     = ["subnet-12345678", "subnet-abcdef12"]
}

variable "security_group_id" {
  description = "Security group ID to attach to Fargate tasks"
  type        = string
  default     = "sg-12345678"
}

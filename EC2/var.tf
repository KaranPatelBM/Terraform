variable "ami_value" {
    description = "Ec2 instance"
}

variable "instance_type" {
    description = "value for instance"  
}

variable "your-key-pair" {
    description = "value for your-key-pair"
}

variable "Music_Discovery_repo_url" {
  description = "GitHub repository URL for the Music_Discovery project"
  type        = string
}

variable "Music_Discovery_playwright_repo_url" {
  description = "GitHub repository URL for the Music_Discovery Playwright tests"
  type        = string
}

variable "react_port" {
  description = "Port number for the React app"
  type        = number
}

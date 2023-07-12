
variable "domainName" {
    description = "Name for the Domain where the public static website is hosted"
    default     = "technicaltask.saramohamed"
    type        = string
}

variable "bucketName" {
    description = "Name for the S3 bucket where the public static website is hosted"
    default     = "technicaltask"
    type        = string
}
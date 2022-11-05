#adiciona a variavel região
variable "region" {
        default = "us-east-1"
        }
variable "name" {
    type = string
    
}
variable "tags" {
    type = map(string)
    default = {}
}
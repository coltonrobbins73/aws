# This file ties together the different modules

module "data_lake" {
  source = "./data-lake"

  # Pass variables as needed
  # ...
}

module "storage" {
  source = "./storage"

  # Pass variables as needed
  # ...
}

module "compute" {
  source = "./compute"

  # Pass variables as needed
  # ...
}

module "networking" {
  source = "./networking"

  # Pass variables as needed
  # ...
}

module "api_gateway" {
  source = "./api-gateway"

  # Pass any necessary variables 
}

module "lambda" {
  source = "./lambda"

  # Pass any necessary variables, including the API Gateway ID 
}
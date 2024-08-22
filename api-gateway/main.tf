resource "aws_api_gateway_rest_api" "data_pipeline_api" {
  name        = "data_pipeline_api"
  description = "API to trigger data downloads"
}

resource "aws_api_gateway_resource" "dataset" {
  rest_api_id = aws_api_gateway_rest_api.data_pipeline_api.id
  parent_id   = aws_api_gateway_rest_api.data_pipeline_api.root_resource_id
  path_part   = "dataset"
}

resource "aws_api_gateway_method" "post_dataset" {
  rest_api_id   = aws_api_gateway_rest_api.data_pipeline_api.id
  resource_id   = aws_api_gateway_resource.dataset.id
  http_method   = "POST"
  authorization = "AWS_IAM"  # Or "NONE" if using API keys
}

resource "aws_api_gateway_integration" "lambda_integration" {
  rest_api_id             = aws_api_gateway_rest_api.data_pipeline_api.id
  resource_id             = aws_api_gateway_resource.dataset.id
  http_method             = aws_api_gateway_method.post_dataset.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.data_download_lambda.invoke_arn  # From your lambda module
}

resource "aws_api_gateway_deployment" "example" {
  rest_api_id = aws_api_gateway_rest_api.data_pipeline_api.id

  triggers = {
    # ... (Triggers to redeploy when changes are made)
  }

  lifecycle {
    create_before_destroy = true 
  }
}

resource "aws_api_gateway_stage" "prod" {
  deployment_id = aws_api_gateway_deployment.example.id
  rest_api_id   = aws_api_gateway_rest_api.data_pipeline_api.id
  stage_name    = "prod"
}
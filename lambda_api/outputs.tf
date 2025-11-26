output "api_url" {
  value = aws_apigatewayv2_api.api.api_endpoint
}

output "lambda_arn" {
  value = aws_lambda_function.fn.arn
}

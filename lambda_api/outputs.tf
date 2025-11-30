output "api_url" {
  value = "${aws_api_gateway_rest_api.rest.execution_arn}"
}

output "lambda_arn" {
  value = aws_lambda_function.fn.arn
}

output "key_id" {
  value = aws_iam_access_key.r53userkey.id
}

output "key_secret" {
  value = aws_iam_access_key.r53userkey.secret
}

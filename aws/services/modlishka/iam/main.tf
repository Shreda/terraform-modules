resource "aws_iam_access_key" "r53userkey" {
  user = aws_iam_user.r53user.name 
}

resource "aws_iam_user" "r53user" {
  name = "r53user"
}

resource "aws_iam_user_policy" "r53_ro" {
  name = "r53ro"
  user = aws_iam_user.r53user.name
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "route53:ListHostedZones",
        "route53:GetChange",
        "route53:ChangeResourceRecordSets"
      ],
      "Resource": [
        "*" 
      ]
    } 
  ]
}
EOF
}

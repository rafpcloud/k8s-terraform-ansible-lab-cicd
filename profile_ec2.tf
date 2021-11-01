resource "aws_iam_role" "ec2_k8s_access_role" {
  name               = "ec2_k8s-role"
  assume_role_policy = file("assumerolepolicy.json")
}

resource "aws_iam_instance_profile" "k8s_profile" {
  name = "k8s_profile"
  role = aws_iam_role.ec2_k8s_access_role.name

}

resource "aws_iam_policy" "policy" {
  name        = "test-policy"
  description = "A test policy"
  policy      = file("ssm.json")
}

resource "aws_iam_policy_attachment" "ec2_k8s_access_role-attachment" {
  name       = "ec2_k8s_access_role-attachment"
  roles      = ["${aws_iam_role.ec2_k8s_access_role.name}"]
  policy_arn = aws_iam_policy.policy.arn
}

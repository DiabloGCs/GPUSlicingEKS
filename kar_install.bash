# Create an AWS Account ID environment variable for convenience
export AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
export CLUSTER_NAME="mig-karpenter-demo"
export AWS_REGION="us-east-1"

# Create a service account IAM policy and role for Karpenter
curl -fsSL https://karpenter.sh/v0.27.0/getting-started/cloudformation.yaml \
  | sed "s/\${AWS_ACCOUNT_ID}/${AWS_ACCOUNT_ID}/g" \
  | sed "s/\${CLUSTER_NAME}/${CLUSTER_NAME}/g" \
  | sed "s/\${AWS_REGION}/${AWS_REGION}/g" \
  > karpenter-cloudformation.yaml

aws cloudformation deploy \
  --stack-name "Karpenter-${CLUSTER_NAME}" \
  --template-file karpenter-cloudformation.yaml \
  --capabilities CAPABILITY_NAMED_IAM

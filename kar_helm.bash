helm repo add karpenter https://charts.karpenter.sh
helm repo update

helm install karpenter karpenter/karpenter \
  --namespace karpenter \
  --create-namespace \
  --version v0.27.0 \
  --set controller.clusterName=${CLUSTER_NAME} \
  --set controller.clusterEndpoint="$(aws eks describe-cluster --name ${CLUSTER_NAME} --query "cluster.endpoint" --output text)" \
  --set controller.aws.defaultInstanceProfile=KarpenterNodeInstanceProfile-${CLUSTER_NAME} \
  --set controller.aws.interruptionQueueName="Karpenter-${CLUSTER_NAME}" \
  --set controller.serviceAccount.annotations."eks\.amazonaws\.com/role-arn"="arn:aws:iam::${AWS_ACCOUNT_ID}:role/KarpenterControllerRole-${CLUSTER_NAME}"

Below is an end-to-end example showing how you can enable GPU slicing (via NVIDIA MIG) on Amazon EKS, including:

Creating an EKS Cluster (using eksctl) with MIG-capable GPU instances.
Enabling MIG via startup script (User Data) on each node.
Deploying the NVIDIA Device Plugin (configured for MIG).
Testing with a sample workload that requests a MIG slice.


Kar files for autoscaling MIG-enabled nodes.

Karpenter automatically creates MIG-enabled GPU nodes.

The device plugin exposes MIG slices as separate K8s resources.

Pods request fractional GPU capacity, improving utilization and cost efficiency.
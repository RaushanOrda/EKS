resource "kubernetes_manifest" "ebs_csi_storage_class" {
  depends_on = [
    aws_eks_addon.aws-ebs-csi-driver
  ]
  manifest = yamldecode(
    <<EOF
    apiVersion: storage.k8s.io/v1
    kind: StorageClass
    metadata:
      name: ebs-sc
    provisioner: ebs.csi.aws.com
    parameters:
      type: gp3
    reclaimPolicy: Retain
    volumeBindingMode: WaitForFirstConsumer
    EOF
  )
}



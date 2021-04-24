terraform {
    backend "s3" {
        bucket = "" #we will override it from azdevps
        key = ""
        region = "us-east-1"

      
    }
}

provider "aws" {
    region = "us-east-1"
}

resource "aws_default_vpc" "default" {
  
}

data "aws_subnet_ids" "mysubnet" {
    vpc_id = aws_default_vpc.default.id
}

provider "kubernetes" {
    host = data.aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
    token = data.aws_aws_eks_cluster.cluster.token
    #load_config_file =
    #version =
}

data "aws_eks_cluster" "cluster" {

    name = module.zeeshank8-cluster.cluster_id

}


data "aws_eks_cluster_auth" "cluster" {
    name = module.zeeshank8-cluster.cluster_id

}


resource "kubernetes_cluster_role_binding" "example" {
    metadata {
        name = "terraform-example"
    }

    role_ref {
        api_group = "rbac.authorization.k8s.io"
        kind      = "ClusterRole"
        name      = "cluster-admin"
    }
    subject {
        kind      = "ServiceAccount"
        name      = "default"
        namespace = "default"
    }

}


module "zeeshank8-cluster" {

    source = "terraform-aws-modules/eks/aws"
    cluster_name = "zeeshank8-cluster"
    cluster_version = "1.14"
    subnets = []
    vpc_id = aws_default_vpc.default.id

    node_groups = [
        {
            instance_type = "t2.micro"
            max_capacity = 5
            desired_capacity = 3
            min_capacity = 3
        }
    ]
    
}


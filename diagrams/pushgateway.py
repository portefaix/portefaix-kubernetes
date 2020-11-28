import diagrams
from diagrams.gcp import compute as compute_gcp
from diagrams.k8s import compute
from diagrams.k8s import network
from diagrams.k8s import podconfig
from diagrams.k8s import rbac
from diagrams.k8s import storage


def k8s_rbac():
    sa = rbac.ServiceAccount()
    # clusterRole = rbac.ClusterRole()
    # clusterRoleBinding = rbac.ClusterRoleBinding()
    # clusterRole << clusterRoleBinding >> sa
    # role = rbac.Role()
    # roleBinding = rbac.RoleBinding()
    # role << roleBinding >> sa
    return sa


def architecture():
    with diagrams.Diagram("Architecture", show=False):
        with diagrams.Cluster("Cloud Platform"):
            with diagrams.Cluster("Kubernetes Cluster"):
                sa = k8s_rbac()

                with diagrams.Cluster("monitoring"):
                    sm = compute_gcp.KubernetesEngine("servicemonitor")
                    svc = network.Service("svc")
                    deploy = compute.Deployment("deploy")
                    deploy << sa
                    pod = compute.Pod("pod")
                    deploy >> pod
                    svc >> pod
                    sm >> svc


def main():
    architecture()


if __name__ == "__main__":
    main()

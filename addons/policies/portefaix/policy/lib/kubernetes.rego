package lib.kubernetes

default is_gatekeeper = false

# is_gatekeeper {
# 	has_field(input, "review")
# 	has_field(input.review, "object")
# }

# object = input {
# 	not is_gatekeeper
# }

# object = input.review.object {
# 	is_gatekeeper
# }

# format(msg) = gatekeeper_format {
# 	is_gatekeeper
# 	gatekeeper_format = {"msg": msg}
# }

# format(msg) = msg {
# 	not is_gatekeeper
# }

# name = object.metadata.name

# kind = object.kind

name = input.metadata.name
kind = input.kind

is_deployment {
	kind = "Deployment"
}

is_pod {
	kind = "Pod"
}

is_service {
  kind = "Service"
}

is_statefulset {
	kind = "StatefulSet"
}

is_daemonset {
	kind = "DaemonSet"
}

is_replicaset {
  kind = "ReplicaSet"
}

is_configmap {
	kind = "ConfigMap"
}

is_secret {
	kind = "Secret"
}

is_service_account {
	kind = "ServiceAccount"
}

is_role {
	kind = "Role"
}

is_role_binding {
	kind = "RoleBinding"
}

is_cluster_role {
	kind = "ClusterRole"
}

is_cluster_role_binding {
	kind = "ClusterRoleBinding"
}

split_image(image) = [image, "latest"] {
	not contains(image, ":")
}

split_image(image) = [name, tag] {
	[name, tag] = split(image, ":")
}

pod_containers(pod) = all_containers {
	keys = {"containers", "initContainers"}
	all_containers = [c | keys[k]; c = pod.spec[k][_]]
}

containers[container] {
	pods[pod]
	all_containers = pod_containers(pod)
	container = all_containers[_]
}

containers[container] {
	all_containers = pod_containers(input)
	container = all_containers[_]
}

pods[pod] {
	is_deployment
	pod = input.spec.template
}

# pods[pod] {
# 	is_daemonset
# 	pod = object.spec.template
# }

# pods[pod] {
# 	is_statefulset
# 	pod = object.spec.template
# }

# pods[pod] {
# 	is_pod
# 	pod = input
# }

volumes[volume] {
	pods[pod]
	volume = pod.spec.volumes[_]
}

# dropped_capability(container, cap) {
# 	container.securityContext.capabilities.drop[_] == cap
# }

# added_capability(container, cap) {
# 	container.securityContext.capabilities.add[_] == cap
# }

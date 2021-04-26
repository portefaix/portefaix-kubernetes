package k8s_labels

test_metadata_without_labels {
	metadata := {}
	not recommended_labels_provided(metadata)
}

test_metadata_with_labels_false {
	metadata := {
		"name": "test-pod",
		"labels": {"app": "my-app"},
	}

	not recommended_labels_provided(metadata)
}

test_metadata_with_labels_true {
	metadata := {
		"name": "test-pod",
		"labels": {
			"app": "my-app",
			"portefaix.xyz/version": "v1.0.0",
		},
	}

	recommended_labels_provided(metadata)
}

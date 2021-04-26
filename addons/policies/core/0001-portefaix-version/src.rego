# @title Portefaix version label is set
#
# See: https://github.com/portefaix/portefaix/.......

package k8s_labels

import data.lib.core # as konstraint_core

policyID := "CORE-0001"

violation[msg] {
	not recommended_labels_provided(core.resource.metadata)
	msg = core.format_with_id(sprintf("%s/%s: does not contain the Portefaix version label", [core.kind, core.name]), "CORE-0001")
}

recommended_labels_provided(metadata) {
	metadata.labels["portefaix.xyz/version"]
}

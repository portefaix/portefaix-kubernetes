---
rfc: 002
status: ✅ accepted
date: 2023-08-06
deciders: nlamirault
consulted:
informed:
spdx-license: Apache-2.0
---

# RFC 002 - OpenTelemetry Adoption Strategy

## 1. 📝 Summary

This RFC proposes adopting OpenTelemetry as the unified standard for collecting, processing, and exporting observability signals (metrics, traces, logs, and profiles) across all Portefaix Kubernetes environments. OpenTelemetry provides a vendor-neutral, open-source framework that addresses current limitations with fragmented observability tooling, inconsistent instrumentation, and vendor lock-in concerns.

**This RFC seeks consensus on adopting OpenTelemetry as the observability standard for Portefaix.**

## 2. 🎯 Motivation

### Current State

Portefaix currently uses a heterogeneous mix of observability tools and instrumentation approaches:

- **Metrics:** Prometheus for metrics collection with custom exporters
- **Traces:** Various APM solutions with inconsistent instrumentation
- **Logs:** Multiple log collectors with different formats
- **Profiles:** Limited or no continuous profiling capabilities

Each signal type operates independently with:

- Different instrumentation libraries per language
- Separate configuration and deployment workflows
- Inconsistent data correlation between signals
- Multiple agents/collectors running per node

### Problems with Current Approach

**1. Observability Fragmentation**

- Different tools for each signal type creates operational silos
- Difficult to correlate metrics, traces, and logs for troubleshooting
- Inconsistent labels, tags, and metadata across signals
- Multiple agents consuming resources (CPU, memory, network)

**2. Vendor Lock-in Risk**

- Proprietary instrumentation libraries tie applications to specific vendors
- Changing observability backends requires re-instrumenting applications
- Data export formats are vendor-specific
- Limited portability between monitoring platforms

**3. Instrumentation Complexity**

- Each language ecosystem has different observability libraries
- Maintaining multiple instrumentation approaches across polyglot systems
- Inconsistent semantic conventions for naming and attributes
- High maintenance overhead for custom integrations

**4. Multi-Cloud Challenges**

- Different observability solutions per cloud provider (CloudWatch, Cloud Monitoring, Azure Monitor)
- Inconsistent experiences across AWS, GCP, Azure, and on-premises environments
- Difficult to aggregate observability data across clouds
- Increased operational complexity managing multiple observability stacks

**5. Scalability and Performance**

- Multiple agents per node increase resource consumption
- Redundant data collection and processing
- Inefficient network utilization sending data to multiple backends
- No unified sampling or filtering strategies

**6. Developer Experience**

- Developers must learn multiple instrumentation approaches
- Inconsistent debugging experiences across services
- Difficult to troubleshoot issues spanning multiple services
- Limited out-of-the-box instrumentation for common frameworks

### Why Now?

**OpenTelemetry Maturity:**

- OpenTelemetry reached GA status for traces and metrics
- Strong ecosystem support from major vendors and cloud providers
- CNCF graduated project with broad community adoption
- Production-ready with proven stability at scale

**Growing Complexity:**

- Portefaix is expanding across multiple clouds (AWS, GCP, Azure, Scaleway)
- Increasing number of microservices requiring observability
- Need for end-to-end distributed tracing
- Team growth requiring standardized practices

**Industry Momentum:**

- Major observability vendors now support OpenTelemetry natively
- Cloud providers provide OpenTelemetry-native services
- Most new observability tools are built on OpenTelemetry
- Delaying adoption will increase technical debt

### Expected Benefits

**Unified Observability:**

- Single instrumentation standard for all signals (metrics, traces, logs, profiles)
- Consistent semantic conventions across all services
- Correlated observability data for better troubleshooting
- Reduced resource consumption with unified collectors

**Vendor Neutrality:**

- Instrument once, export to any backend
- Freedom to change observability vendors without code changes
- Multi-vendor support for hybrid strategies
- Future-proof against vendor changes

**Developer Experience:**

- Auto-instrumentation for popular frameworks and libraries
- Consistent APIs across all programming languages
- Rich context propagation across service boundaries
- Lower learning curve with standardized approaches

**Operational Efficiency:**

- Single agent/collector deployment model
- Centralized configuration management
- Unified data processing pipelines
- Better resource utilization

**Cloud-Native Integration:**

- Native Kubernetes support with operators
- Cloud provider integrations (AWS X-Ray, GCP Cloud Trace, Azure Monitor)
- Service mesh compatibility (Istio, Linkerd)
- GitOps-friendly deployment models

## 3. 📖 Guide-level Explanation

### Desired Workflow

OpenTelemetry enables a unified observability workflow:

**1. Instrument Applications Once:**

```python
# Python example with OpenTelemetry auto-instrumentation
from opentelemetry import trace
from opentelemetry import metrics

# Get tracer
tracer = trace.get_tracer(__name__)

# Get meter
meter = metrics.get_meter(__name__)

# Create instruments
request_counter = meter.create_counter(
    "http.server.requests",
    description="Total HTTP requests"
)

# Use in application
with tracer.start_as_current_span("process_request") as span:
    span.set_attribute("http.method", "GET")
    request_counter.add(1, {"http.status_code": 200})
```

**2. Deploy OpenTelemetry Collectors:**

```yaml
# Unified collector configuration
apiVersion: opentelemetry.io/v1alpha1
kind: OpenTelemetryCollector
metadata:
  name: otel-collector
spec:
  config: |
    receivers:
      otlp:
        protocols:
          grpc:
          http:
      prometheus:
        config:
          scrape_configs:
            - job_name: 'kubernetes-pods'

    processors:
      batch:
      memory_limiter:
        limit_mib: 512

    exporters:
      # Send to multiple backends
      prometheus:
        endpoint: "prometheus:9090"
      jaeger:
        endpoint: "jaeger:14250"
      loki:
        endpoint: "http://loki:3100/loki/api/v1/push"

    service:
      pipelines:
        traces:
          receivers: [otlp]
          processors: [memory_limiter, batch]
          exporters: [jaeger]
        metrics:
          receivers: [otlp, prometheus]
          processors: [memory_limiter, batch]
          exporters: [prometheus]
        logs:
          receivers: [otlp]
          processors: [memory_limiter, batch]
          exporters: [loki]
```

**3. Automatic Context Propagation:**

```go
// Go example showing distributed tracing
func handleRequest(w http.ResponseWriter, r *http.Request) {
    // OpenTelemetry automatically propagates context
    ctx := r.Context()

    // Start a span for this operation
    ctx, span := tracer.Start(ctx, "handle_request")
    defer span.End()

    // Call downstream service - context automatically propagated
    resp, err := httpClient.Get(ctx, "http://downstream-service/api")
    if err != nil {
        span.RecordError(err)
        span.SetStatus(codes.Error, err.Error())
    }

    // Metrics are automatically tagged with trace context
    requestDuration.Record(ctx, time.Since(start).Milliseconds())
}
```

**4. Unified Query Experience:**

```promql
# Metrics - still use Prometheus queries
rate(http_server_requests_total[5m])

# Traces - query with trace ID found in logs
trace_id: "4bf92f3577b34da6a3ce929d0e0e4736"

# Logs - now enriched with trace context
{namespace="production"} | json | trace_id="4bf92f3577b34da6a3ce929d0e0e4736"
```

### Comparison with Current Approach

**Current (Fragmented):**

```
Application Code:
├── Prometheus client library (metrics)
├── Jaeger client library (traces)
├── Custom logging library (logs)
└── Manual correlation attempts

Infrastructure:
├── Prometheus scraper (DaemonSet)
├── Jaeger agent (DaemonSet)
├── Fluentd/Fluent Bit (DaemonSet)
└── Multiple exporters per node

Result:
❌ 3+ agents per node
❌ Inconsistent instrumentation
❌ Manual correlation required
❌ Vendor-specific libraries
```

**Desired (OpenTelemetry):**

```
Application Code:
└── OpenTelemetry SDK (all signals)
    ├── Metrics
    ├── Traces
    ├── Logs
    └── Auto-correlation

Infrastructure:
└── OpenTelemetry Collector (unified)
    ├── Receives all signals
    ├── Processes data once
    └── Exports to multiple backends

Result:
✅ Single agent deployment
✅ Unified instrumentation
✅ Automatic correlation
✅ Vendor-neutral
```

## 4. 🔬 Reference-level Explanation

### High-Level Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    Application Layer                        │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐       │
│  │ Microservice │  │ Microservice │  │ Microservice │       │
│  │      A       │  │      B       │  │      C       │       │
│  │              │  │              │  │              │       │
│  │  OTel SDK    │  │  OTel SDK    │  │  OTel SDK    │       │
│  └──────┬───────┘  └──────┬───────┘  └──────┬───────┘       │
│         │                 │                 │               │
│         └─────────────────┴─────────────────┘               │
│                           │ OTLP (gRPC/HTTP)                │
└───────────────────────────┼─────────────────────────────────┘
                            │
                            ▼
┌─────────────────────────────────────────────────────────────┐
│              OpenTelemetry Collector Layer                  │
│                                                             │
│  ┌────────────────────────────────────────────────────────┐ │
│  │              OpenTelemetry Collector                   │ │
│  │                                                        │ │
│  │  Receivers  →  Processors  →  Exporters                │ │
│  │  ├─ OTLP         ├─ Batch        ├─ Prometheus         │ │
│  │  ├─ Prometheus   ├─ Filter       ├─ Jaeger             │ │
│  │  ├─ Jaeger       ├─ Transform    ├─ Loki               │ │
│  │  └─ ...          └─ ...          └─ ...                │ │
│  └────────────────────────────────────────────────────────┘ │
│                                                             │
└───────┬─────────────┬───────────────┬───────────────┬───────┘
        │             │               │               │
        ▼             ▼               ▼               ▼
┌─────────────┐  ┌──────────┐  ┌─────────────┐  ┌──────────┐
│ Prometheus  │  │  Jaeger  │  │    Loki     │  │  Cloud   │
│  (Metrics)  │  │ (Traces) │  │   (Logs)    │  │ Backends │
└─────────────┘  └──────────┘  └─────────────┘  └──────────┘
```

### OpenTelemetry Components

**1. OpenTelemetry SDK (Application Layer)**

- Provides APIs for metrics, traces, and logs
- Available for all major languages (Go, Python, Java, Node.js, .NET, Rust)
- Handles context propagation automatically
- Supports both manual and auto-instrumentation

**2. OpenTelemetry Collector (Infrastructure Layer)**

- Vendor-agnostic telemetry data pipeline
- Receives data in multiple formats
- Processes and transforms telemetry data
- Exports to multiple backends simultaneously
- Can run as agent (per-node) or gateway (centralized)

**3. OpenTelemetry Operator (Kubernetes)**

- Manages OpenTelemetry Collector deployments
- Provides auto-instrumentation for applications
- Handles configuration via CRDs
- Integrates with Kubernetes ecosystem

### Signal Types

**Traces:**

- Distributed transaction monitoring
- Request flow across services
- Performance bottleneck identification
- Root cause analysis

**Metrics:**

- System and application performance data
- Resource utilization tracking
- SLI/SLO monitoring
- Alerting based on thresholds

**Logs:**

- Structured log events
- Enriched with trace context
- Correlation with traces and metrics
- Debugging and audit trails

**Profiles (Future):**

- Continuous profiling data
- CPU and memory profiles
- Performance optimization insights

### Deployment Models

**1. Agent Mode (DaemonSet):**

- Collector runs on each node
- Applications send to local collector
- Reduces network overhead
- Better for high-volume scenarios

**2. Gateway Mode (Deployment):**

- Centralized collector deployment
- Aggregates data from multiple sources
- Easier to manage at scale
- Better for advanced processing

**3. Hybrid Mode:**

- Agents for initial collection
- Gateways for processing and routing
- Best of both approaches
- Production-recommended architecture

### Technical Requirements

**Application Layer:**

1. OpenTelemetry SDK integration in services
2. Semantic conventions for consistent naming
3. Context propagation across service boundaries
4. Support for both synchronous and asynchronous operations

**Infrastructure Layer:**

1. OpenTelemetry Collector deployment (agent and/or gateway)
2. Configuration management (GitOps-compatible)
3. Resource limits and performance tuning
4. High availability for collectors

**Integration Layer:**

1. Backend compatibility (Prometheus, Jaeger, Loki, cloud services)
2. Data format conversions where needed
3. Authentication and authorization
4. Network policies and security

**Operational Requirements:**

1. Monitoring of the observability pipeline itself
2. Sampling strategies for high-volume scenarios
3. Data retention policies
4. Disaster recovery procedures

## 5. Drawbacks

### Migration Complexity

**Re-instrumentation Required:**

- Must update all services to use OpenTelemetry SDKs
- Cannot fully automate for all custom metrics
- Risk of losing historical metric names/labels
- Testing required to ensure parity with existing instrumentation

**Operational Overhead During Transition:**

- Running both old and new observability stacks temporarily
- Doubled resource consumption during migration
- Potential gaps in observability during cutover
- Training teams on new tooling and concepts

### Learning Curve

**New Concepts:**

- Understanding OpenTelemetry architecture and components
- Learning semantic conventions and best practices
- Collector configuration complexity
- Debugging distributed telemetry pipelines

**Documentation:**

- OpenTelemetry documentation is extensive but can be overwhelming
- Many configuration options to understand
- Ecosystem is evolving rapidly
- Best practices still emerging for some scenarios

### Resource Consumption

**Collector Overhead:**

- OpenTelemetry Collector consumes CPU and memory
- Processing pipelines add latency
- Network bandwidth for telemetry data
- Storage for buffering and retry mechanisms

**Application Overhead:**

- SDK adds runtime overhead to applications
- Context propagation has performance cost
- Additional memory for telemetry data
- Potential impact on application performance

### Ecosystem Maturity

**Varying Signal Maturity:**

- Traces and metrics are stable
- Logs specification is still stabilizing
- Profiles are in early stages
- Some language SDKs more mature than others

**Backend Support:**

- Not all observability backends fully support OpenTelemetry natively
- Some require translation layers
- Vendor-specific features may not be accessible
- Breaking changes possible in newer specifications

### Configuration Complexity

**Collector Configuration:**

- YAML configuration can become complex
- Many processors and options to understand
- Debugging pipeline issues can be challenging
- Configuration validation is limited

**Multi-tenancy:**

- Isolating telemetry data per namespace/team
- Managing collector resources fairly
- RBAC for telemetry configuration
- Cost attribution for cloud-based backends

## 6. Alternatives

### Alternative 1: Maintain Current Fragmented Approach

**Overview:** Continue using separate tools for metrics (Prometheus), traces (various APM), and logs (Fluentd/Fluent Bit).

**Pros:**

- ✅ No migration effort required
- ✅ Teams already familiar with tools
- ✅ Existing dashboards and alerts work as-is
- ✅ No learning curve

**Cons:**

- 🚫 Doesn't solve observability fragmentation
- 🚫 Vendor lock-in continues
- 🚫 Multiple agents per node increase costs
- 🚫 Correlation remains manual and difficult
- 🚫 Technical debt accumulates

**Verdict:** This maintains status quo but doesn't address the core problems driving this RFC.

---

### Alternative 2: Adopt Vendor-Specific Observability Platform

**Overview:** Adopt a single vendor platform (Datadog, New Relic, Dynatrace, etc.) that provides unified observability.

**Pros:**

- ✅ Unified experience out-of-the-box
- ✅ Comprehensive features and integrations
- ✅ Professional support
- ✅ Easier initial setup

**Cons:**

- 🚫 Strong vendor lock-in
- 🚫 Proprietary instrumentation
- 🚫 Significant ongoing costs
- 🚫 Data egress concerns for multi-cloud
- 🚫 Limited flexibility for custom backends
- 🚫 Difficult to migrate away later

**Verdict:** Provides unified observability but creates vendor dependency we want to avoid.

---

### Alternative 3: Build Custom Observability Solution

**Overview:** Develop a custom in-house solution tailored to Portefaix needs.

**Pros:**

- ✅ Complete control over features
- ✅ Optimized for specific requirements
- ✅ No vendor dependencies
- ✅ Potential for innovation

**Cons:**

- 🚫 Massive development effort
- 🚫 Requires dedicated team to maintain
- 🚫 Risk of becoming outdated
- 🚫 Lack of community support
- 🚫 Unlikely to match OpenTelemetry ecosystem

**Verdict:** Not feasible given resources and reinvents the wheel.

---

### Alternative 4: Wait for OpenTelemetry to Mature Further

**Overview:** Delay adoption until OpenTelemetry ecosystem is more mature.

**Pros:**

- ✅ More stable specifications
- ✅ Better documentation
- ✅ More production examples
- ✅ Improved tooling

**Cons:**

- 🚫 Technical debt continues accumulating
- 🚫 OpenTelemetry is already production-ready for traces and metrics
- 🚫 Delays solving current pain points
- 🚫 Migration becomes harder as systems grow
- 🚫 Missing opportunity to influence standards

**Verdict:** OpenTelemetry is mature enough for adoption now; waiting increases migration costs.

---

### Alternative 5: Hybrid Approach (Prometheus + OpenTelemetry)

**Overview:** Keep Prometheus for metrics, adopt OpenTelemetry for traces and logs only.

**Pros:**

- ✅ Leverage existing Prometheus investment
- ✅ Smaller initial migration scope
- ✅ Gradual transition
- ✅ Lower risk

**Cons:**

- 🚫 Still maintains some fragmentation
- 🚫 Two instrumentation approaches for metrics
- 🚫 Misses unified metrics benefits
- 🚫 OpenTelemetry supports Prometheus format anyway

**Verdict:** Possible transitional approach but doesn't achieve full benefits of standardization.

## 7. Unresolved Questions

**We need consensus and input on the following:**

### Strategic Questions

1. **Timeline for Adoption:**
   - What is the target timeline for full OpenTelemetry adoption?
   - Should we set a deadline for deprecating old instrumentation?

2. **Migration Strategy:**
   - Big bang migration vs. gradual service-by-service?
   - Which services should be migrated first (pilot program)?
   - How do we handle services that are rarely updated?

3. **Backwards Compatibility:**
   - How long should we maintain dual instrumentation?
   - What is the plan for legacy metrics that don't translate cleanly?
   - How do we handle existing dashboards and alerts?

### Technical Questions

4. **Collector Deployment Model:**
   - Agent mode (DaemonSet) vs. Gateway mode (Deployment) vs. Hybrid?
   - How many collector instances per cluster?
   - What resource limits should be set?

5. **Sampling Strategy:**
   - What sampling rates for high-volume traces?
   - Head-based vs. tail-based sampling?
   - How to handle sampling for low-traffic services?

6. **Backend Strategy:**
   - Continue with Prometheus, Jaeger, Loki?
   - Evaluate OpenTelemetry-native backends (Tempo, etc.)?
   - What about cloud provider backends (X-Ray, Cloud Trace)?

7. **Auto-instrumentation:**
   - Should we use OpenTelemetry Operator's auto-instrumentation?
   - Which languages/frameworks are candidates?
   - Where is manual instrumentation necessary?

### Organizational Questions

8. **Team Training:**
   - What training is needed for development teams?
   - What training is needed for operations teams?
   - Who will be OpenTelemetry champions/experts?

9. **Standards and Guidelines:**
   - What semantic conventions should we standardize on?
   - How do we enforce consistent instrumentation practices?
   - What are the required vs. optional telemetry signals?

10. **Governance:**
    - Who approves OpenTelemetry configuration changes?
    - How do we handle collector capacity planning?
    - What SLOs do we set for the observability pipeline itself?

### Cost Questions

11. **Resource Planning:**
    - What is the expected resource consumption increase?
    - How does this impact infrastructure costs?
    - Are there cost savings from consolidation?

12. **Backend Costs:**
    - Will data volumes increase to backends?
    - Do we need to revisit retention policies?
    - Should we implement aggressive sampling to control costs?

## 8. Future Possibilities

### Short-Term (0-6 months)

**Enhanced Observability:**

- Implement distributed tracing across all services
- Unified dashboards correlating metrics, traces, and logs
- Improved incident response with correlated telemetry
- Automated anomaly detection using correlated signals

**Operational Improvements:**

- Self-service observability for development teams
- Standardized SLI/SLO definitions using OpenTelemetry
- Automated instrumentation for new services
- Observability-as-code with GitOps workflows

### Medium-Term (6-12 months)

**Advanced Features:**

- Continuous profiling integration (when OpenTelemetry profiles GA)
- Exemplars linking metrics to traces
- Trace-based testing and validation
- Custom processors for Portefaix-specific needs

**Cross-Platform:**

- Consistent observability across Kubernetes, VMs, and serverless
- Multi-cluster telemetry aggregation
- Edge computing observability
- IoT device telemetry (if applicable)

### Long-Term (12+ months)

**AI/ML Integration:**

- Anomaly detection using machine learning on telemetry data
- Predictive analytics for capacity planning
- Automated root cause analysis
- Intelligent sampling based on learned patterns

**Platform Evolution:**

- OpenTelemetry as foundation for reliability engineering
- Chaos engineering integrated with telemetry
- Cost optimization using telemetry insights
- Compliance and security observability

**Ecosystem Contributions:**

- Contribute custom processors back to OpenTelemetry
- Share Portefaix-specific semantic conventions
- Collaborate on multi-cloud patterns
- Participate in OpenTelemetry community

**Next Steps:**

1. Review and gather feedback
2. Schedule RFC discussion session
3. Run proof-of-concept with 2-3 pilot services
4. Create detailed migration plan (separate ADR)
5. Set up OpenTelemetry governance model

# Security Policy

## Supported Versions

We release patches for security vulnerabilities. Which versions are eligible for
receiving such patches depends on the CVSS v3.0 Rating:

| Version  | Supported          |
| -------- | ------------------ |
| Latest   | :white_check_mark: |
| < Latest | :x:                |

## Reporting a Vulnerability

If you discover a security vulnerability within this project, please follow
these steps:

1. **Do not** open a public GitHub issue for the vulnerability
2. Send an email to nicolas.lamirault@gmail.com with:
   - A description of the vulnerability
   - Steps to reproduce the issue
   - Potential impact
   - Any suggested fixes (if applicable)

We will acknowledge receipt of your vulnerability report within 48 hours and
will send a more detailed response within 7 days indicating the next steps in
handling your report.

After the initial reply to your report, we will endeavor to keep you informed of
the progress being made towards a fix and full announcement. We may ask for
additional information or guidance surrounding the reported issue.

## Security Update Process

1. The security issue is received and assigned to a primary handler
2. The problem is confirmed and a list of affected versions is determined
3. Code is audited to find any similar problems
4. Fixes are prepared for all supported releases
5. New releases are issued and announced

## Security Best Practices

When using this project, we recommend:

- Keep your Kubernetes clusters up to date
- Regularly update dependencies
- Follow the principle of least privilege
- Enable audit logging
- Use network policies to restrict traffic
- Regularly scan container images for vulnerabilities
- Implement proper secret management
- Enable RBAC and use service accounts appropriately

## Known Security Considerations

- This project deploys infrastructure components that require proper RBAC
  configuration
- Secrets should be managed using external secret management solutions
- Network policies should be configured according to your security requirements

## Security Tools and Scanning

This project uses several security tools:

- **OSSF Scorecard**: Automated security analysis
- **Dependabot**: Automated dependency updates
- **Pre-commit hooks**: Local security checks before commits
- **License scanning**: Ensures proper license compliance

## Contact

For security concerns, contact: nicolas.lamirault@gmail.com

For general questions, use GitHub Issues:
https://github.com/portefaix/portefaix-kubernetes/issues

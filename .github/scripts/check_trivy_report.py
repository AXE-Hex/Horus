#!/usr/bin/env python3
"""Print non-sensitive scanner metadata and fail on security findings."""

import json
import sys
from pathlib import Path


report = json.loads(Path(sys.argv[1]).read_text(encoding="utf-8"))
failed = False

for result in report.get("Results", []):
    target = result.get("Target", "unknown target")
    for secret in result.get("Secrets", []):
        print(
            f"Secret finding: target={target} "
            f"rule={secret.get('RuleID', 'unknown')} "
            f"line={secret.get('StartLine', 'unknown')}"
        )
        failed = True

    for vuln in result.get("Vulnerabilities", []):
        severity = vuln.get("Severity", "UNKNOWN").upper()
        if severity in {"CRITICAL", "HIGH"}:
            print(
                f"Vulnerability: target={target} "
                f"id={vuln.get('VulnerabilityID', 'unknown')} "
                f"package={vuln.get('PkgName', 'unknown')} severity={severity}"
            )
            failed = True

    for misconfig in result.get("Misconfigurations", []):
        severity = misconfig.get("Severity", "UNKNOWN").upper()
        if severity in {"CRITICAL", "HIGH"}:
            print(
                f"Misconfiguration: target={target} "
                f"id={misconfig.get('ID', 'unknown')} severity={severity}"
            )
            failed = True

if failed:
    sys.exit("Security findings detected; sensitive evidence was omitted.")

print("No secret findings, critical/high vulnerabilities, or critical/high misconfigurations.")

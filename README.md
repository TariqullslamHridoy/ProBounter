
# ProBounter v2.0
> **Automated Asset Reconnaissance & Security Auditing Tool**

[![Bounty-Ready](https://img.shields.io/badge/Bounty-Ready-green.svg)](#)
[![Kali Linux](https://img.shields.io/badge/Platform-Kali%20Linux-blue.svg)](#)
[![MIT License](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

ProBounter is a professional-grade Bash utility designed to streamline the **Information Gathering** and **Vulnerability Assessment** phases of a penetration test. Built specifically for the **Break For Bounty (HW-6)** assignment, it automates intelligence collection to help researchers identify low-hanging fruit and critical security gaps.

---

## ✨ Key Features
- **Interactive Interface:** Optimized CLI with a professional ASCII banner and color-coded real-time logging.
- **DNS Intelligence:** Automated extraction of DNS records using `dig` and `host` utilities.
- **Service Discovery:** Stealthy port scanning and service version detection powered by `Nmap`.
- **Security Header Auditor:** Validates the implementation of critical security headers (`CSP`, `HSTS`, `XFO`, etc.) to detect misconfigurations.
- **Structured Reporting:** Automatically organizes logs into timestamped directories for professional data management.

## 🛠 Prerequisites
Ensure the following tools are available in your environment:
- `nmap` - Network exploration and security auditing.
- `curl` - Data transfer and header inspection.
- `dnsutils` - DNS lookup suite.

## 🚀 Installation & Usage

### 1. Clone the Repository
```bash
git clone https://github.com/TariqullslamHridoy/ProBounter.git
cd ProBounter

```

### 2. Permissions

```bash
chmod +x pro_bounter.sh

```

### 3. Execute Scan

```bash
./pro_bounter.sh -t <target.com>

```

---

## 📂 Data Structure

The tool generates a unique directory for every session, ensuring no data overlap:

```text
recon_YYYY-MM-DD_Domain/
├── dns_info.txt         # Raw DNS query results
├── nmap_report.txt      # Service and port identification
├── headers.txt          # Full HTTP response headers
└── vulnerabilities.txt   # Identified security misconfigurations

```

## 📜 Disclaimer

This tool is for educational and authorized security testing purposes only. Usage against targets without prior mutual consent is illegal.

---

**Developed by:** [Tariqul Islam Hridoy](https://www.facebook.com/CyberTariqul)

**Project:** Break For Bounty - HW 6

```

```
